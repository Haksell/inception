FROM debian:bullseye

RUN groupadd -r -g 999 redis && useradd -r -g redis -u 999 redis
RUN apt-get update -y && apt-get install -y redis redis-server && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

EXPOSE 6379
ENTRYPOINT ["redis-server", "--protected-mode", "no"]