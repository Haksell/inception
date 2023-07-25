FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y php7.4 php7.4-mysql wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" \
    && mv adminer-4.8.1.php index.php

EXPOSE 8080

CMD ["php7.4", "-S", "0.0.0.0:8080"]
