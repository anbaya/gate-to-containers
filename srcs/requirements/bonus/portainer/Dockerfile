FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download Portainer Binary
RUN wget https://github.com/portainer/portainer/releases/download/2.19.5/portainer-2.19.5-linux-amd64.tar.gz \
    && tar -xvf portainer-2.19.5-linux-amd64.tar.gz \
    && rm portainer-2.19.5-linux-amd64.tar.gz

# Portainer data directory
RUN mkdir -p /data

# Run Portainer
WORKDIR /portainer
CMD ["./portainer"]
