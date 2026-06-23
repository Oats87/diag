FROM ubuntu:24.04

LABEL org.opencontainers.image.title="diag" \
      org.opencontainers.image.description="Ubuntu-based Kubernetes diagnostics pod" \
      org.opencontainers.image.authors="Chris Kim <me@chrishkim.com>" \
      org.opencontainers.image.source="https://github.com/Oats87/diag"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        bash ca-certificates curl wget git jq vim less screen \
        net-tools iproute2 iputils-ping dnsutils traceroute mtr-tiny \
        tcpdump nmap netcat-openbsd socat iperf3 iptables procps \
        fio mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# kubectl (latest stable), arch-aware via buildx TARGETARCH
ARG TARGETARCH
RUN curl -fsSL "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" \
        -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && kubectl version --client

ENTRYPOINT ["/bin/bash", "-c", "trap : TERM INT; sleep infinity & wait"]
