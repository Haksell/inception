FROM alpine:3.17.4

RUN apk update && \
    apk upgrade && \
    apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl && \
    apk add --no-cache wget curl supervisor tar

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress /var/www/localhost/htdocs/wordpress && \
    rm latest.tar.gz

RUN chown -R nobody.nobody /var/www/localhost/htdocs/wordpress && \
    chmod -R 755 /var/www/localhost/htdocs/wordpress

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i 's/;listen.owner = nobody/listen.owner = nobody/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;listen.group = nobody/listen.group = nobody/g' /etc/php7/php-fpm.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' /etc/php7/php-fpm.d/www.conf

RUN echo "[supervisord]\nnodaemon=true\n[program:php-fpm7]\ncommand=php-fpm7 -F\nautostart=true\nautorestart=true" > /etc/supervisord.conf

COPY wp-config.php /var/www/localhost/htdocs/wordpress/

EXPOSE 9000

CMD ["/usr/bin/supervisord"]
