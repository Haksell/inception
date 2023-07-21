FROM alpine:3.17.4
RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen
RUN rm -f /var/cache/apk/*
COPY mariadb.sh /scripts/mariadb.sh
RUN chmod -R 755 /scripts
EXPOSE 3306
ENTRYPOINT ["/scripts/mariadb.sh"]