FROM alpine:3.17.4

RUN apk add --no-cache mariadb mariadb-client && rm -f /var/cache/apk/*

EXPOSE 3306

COPY tools/mariadb.sh /mariadb.sh
RUN chmod -R 755 /mariadb.sh
ENTRYPOINT ["/mariadb.sh"]