FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/portainer/portainer/releases/download/2.18.4/portainer-2.18.4-linux-amd64.tar.gz -O portainer.tar.gz \
    && tar -xzf portainer.tar.gz -C /usr/local/bin/ \
    && rm portainer.tar.gz

RUN chmod +x /usr/local/bin/portainer/portainer

RUN mkdir -p /data

EXPOSE 9000

COPY tools/portainer.sh /portainer.sh
RUN chmod +x /portainer.sh
ENTRYPOINT ["/portainer.sh"]
