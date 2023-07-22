FROM php:8.0-fpm-alpine

RUN set -ex; \
    apk add --no-cache \
    bash \
    dpkg-dev dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkgconf \
    re2c \
    freetype-dev \
    icu-dev \
    ;

RUN docker-php-ext-install -j "$(nproc)" mysqli;

RUN set -eux; \
    curl -o wordpress.tar.gz -fL "https://wordpress.org/wordpress-6.2.2.tar.gz"; \
    tar -xzf wordpress.tar.gz -C /usr/src/; \
    rm wordpress.tar.gz; \
    chown -R www-data:www-data /usr/src/wordpress; \
    mkdir wp-content; \
    chown -R www-data:www-data wp-content; \
    chmod -R 1777 wp-content

VOLUME /var/www/html

COPY --chown=www-data:www-data wp-config-docker.php /usr/src/wordpress/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]