# talos-scripts

## get the cluster URLs of a chart or all charts

```shell
curl -sSL https://raw.githubusercontent.com/xstar97/talos-scripts/refs/heads/main/scripts/dns.sh | bash -s
```

```shell
curl -sSL https://raw.githubusercontent.com/xstar97/talos-scripts/refs/heads/main/scripts/dns.sh | bash -s NAMESPACE
```

## get the shell or logs of a chart

### logs

```shell
curl -sSL https://raw.githubusercontent.com/xstar97/talos-scripts/refs/heads/main/scripts/pods.sh | bash -s -l NAMESPACE
```

### shell

```shell
curl -sSL https://raw.githubusercontent.com/xstar97/talos-scripts/refs/heads/main/scripts/pods.sh | bash -s -s NAMESPACE
```
