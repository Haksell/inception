FROM alpine:3.17.4

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

COPY mariadb.sh /scripts/entrypoint.sh
COPY init.sql /scripts/init.sql

RUN mkdir /docker-entrypoint-initdb.d && \
    chmod -R 755 /scripts

EXPOSE 3306

ENTRYPOINT ["/scripts/entrypoint.sh"]