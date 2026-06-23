# diag

Ubuntu 24.04 diagnostics pod for Kubernetes / OpenShift.

A small multi-arch (amd64 + arm64) container that bundles common network,
storage, DNS, and Kubernetes diagnostic tools. Deploy it into a cluster, `exec`
in, and troubleshoot.

## What's inside

- **Network:** `iproute2`, `net-tools`, `iputils-ping`, `dnsutils` (`dig`/`nslookup`),
  `traceroute`, `mtr`, `tcpdump`, `nmap`, `netcat`, `socat`, `iperf3`, `iptables`
- **Storage:** `fio`
- **Database:** `mariadb-client` (`mysql`)
- **Kubernetes:** `kubectl` (latest stable)
- **General:** `curl`, `wget`, `git`, `jq`, `vim`, `less`, `screen`, `procps`

## Usage

### Quick one-off pod

```sh
kubectl run diag --image=docker.io/oats87/diag:latest
kubectl exec -it diag -- bash
# when finished:
kubectl delete pod diag
```

### From the manifest

```sh
kubectl apply -f deploy/k8s/diag.yaml
kubectl exec -it deploy/diag -- bash
# when finished:
kubectl delete -f deploy/k8s/diag.yaml
```

Some tools (`tcpdump`, `iptables`, raw-socket `nmap` scans) need extra Linux
capabilities. Uncomment the `securityContext` block in `deploy/k8s/diag.yaml` to
grant `NET_ADMIN` / `NET_RAW`.

## Building locally

Single-arch (loads into your local Docker):

```sh
docker build -t diag:local .
```

Multi-arch (requires buildx; push to a registry or build without `--load`):

```sh
docker buildx build --platform linux/amd64,linux/arm64 -t diag:local .
```

## Publishing

Pushes to `master` (and `v*` tags) trigger the GitHub Actions workflow in
`.github/workflows/build.yml`, which builds for amd64 + arm64 and pushes to
`docker.io/oats87/diag`. It requires two repository secrets:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN` (a Docker Hub access token)

## Adding packages

Add the package to the `apt-get install` line in the `Dockerfile` and rebuild.
