#!/bin/bash

lock_file="/var/www/html/.setup_complete"

if [ ! -f $lock_file ]; then
    cd /var/www/html

    wp core download --allow-root
    rm -f /var/www/html/wp-config.php
    wp config create --dbname=mariadb --dbhost=mariadb --dbuser=$MYSQL_USER --dbpass=wordpress --allow-root --skip-check

    until wp db check --path=/var/www/html --quiet --allow-root; do
        echo "Waiting for MySQL..."
        sleep 1
    done

    wp core install --url="axbrisse.42.fr" --title="Ooooh very googoo gaga" --admin_user="axbrisse" --admin_password="axbrisse" --admin_email="axbrisse@student.42.fr" --allow-root
    wp user create utenret utenret@example.com --role=subscriber --user_pass=utenret --allow-root
    wp theme install twentyseventeen --activate --allow-root
    wp post delete $(wp post list --format=ids --allow-root) --allow-root
    wp post create --post_type=post --post_title="Hello Inception!" --post_content="lol" --post_status=publish --allow-root

    touch $lock_file
else
    echo "Setup has already been run, skipping..."
fi

exec php-fpm7.4 -F
