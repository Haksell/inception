FROM debian:bullseye

RUN apt-get update && apt-get install -y curl php7.4-fpm php7.4-mysql mariadb-client php-redis php7.4-gd php-imagick
RUN mkdir -p /run/php
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY files/42logo.png /42logo.png
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh
ENTRYPOINT ["/wordpress.sh"]
