#!/bin/bash
# code generally taken from https://github.com/Heavybullets8/heavy_script/blob/main/functions/dns/dns_verbose.sh
# adapted for kubernetes/talos
# ./dns.sh to list all charts
# ./dns.sh namespace to list a namespace chart(s)
dns_verbose(){
    chart_names=("${@}")

    # Get all namespaces and services
    if [[ ${#chart_names[@]} -eq 0 ]]; then
        services=$(kubectl get service --no-headers -A | sort -u)
    else
        pattern=$(IFS='|'; echo "${chart_names[*]}")
        services=$(kubectl get service --no-headers -A | grep -E "^($pattern)[[:space:]]" | sort -u)
    fi

    if [[ -z $services ]]; then
        echo "No services found"
        exit 1
    fi

    output=""

    # Iterate through each namespace and service
    while IFS=$'\n' read -r service; do
        namespace=$(echo "$service" | awk '{print $1}')
        svc_name=$(echo "$service" | awk '{print $2}')
        ports=$(echo "$service" | awk '{print $6}')

        # Print namespace header only when it changes
        if [[ "$namespace" != "$prev_namespace" ]]; then
            output+="\n${namespace}:\n"
        fi
        
        # Construct the DNS URL format without http(s)
        dns_name="${svc_name}.${namespace}.svc.cluster.local"

        # Append DNS and port in a cleaner format
        output+="  ${dns_name}:${ports}\n"

        # Update previous namespace for comparison
        prev_namespace="$namespace"
    done <<< "$services"

    # Format and display the output
    echo -e "$output" | sed '1d;$d'
}

# Run the function with provided arguments
dns_verbose "$@"
