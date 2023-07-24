FROM alpine:3.17.4

RUN apk add --no-cache mariadb mariadb-server-utils && rm -f /var/cache/apk/*

EXPOSE 3306

COPY mariadb.sh /mariadb.sh
RUN chmod -R 755 /mariadb.sh
ENTRYPOINT ["/mariadb.sh"]