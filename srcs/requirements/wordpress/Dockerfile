FROM debian:bullseye

RUN apt-get update && apt-get install -y curl php7.4-fpm php7.4-mysql mariadb-client

WORKDIR /var/www/html

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

COPY wordpress.sh /wordpress.sh
RUN chmod +x /wordpress.sh
ENTRYPOINT ["/wordpress.sh"]
