#!/bin/bash

cd /var/www/html

wp core download --allow-root
wp config create --dbname=mariadb --dbuser=root --dbpass=wordpress --allow-root --skip-check --dbhost=mariadb

until wp db check --path=/var/www/html --quiet --allow-root; do
    echo "Waiting for MySQL..."
    sleep 1
done

rm /var/www/html/wp-config.php
wp core install --url="axbrisse.42.fr" --title="Ooooh very googoo gaga" --admin_user="admin" --admin_password="admin" --admin_email="axbrisse@student.42.fr" --allow-root

php-fpm7.4 -F
