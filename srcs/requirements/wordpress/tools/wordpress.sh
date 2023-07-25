#!/bin/bash

lock_file="/var/www/html/.setup_complete"

if [ ! -f $lock_file ]; then
    cd /var/www/html

    wp core download --allow-root
    rm -f /var/www/html/wp-config.php
    wp config create --dbname=$DB_NAME --dbhost=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_USER_PASSWORD --allow-root --skip-check

    until wp db check --path=/var/www/html --quiet --allow-root; do
        echo "Waiting for MySQL..."
        sleep 1
    done

    wp core install --url="axbrisse.42.fr" --title="Ooooh very googoo gaga" --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    wp user create $WP_SUBSCRIBER_USERNAME $WP_SUBSCRIBER_EMAIL --role=subscriber --user_pass=$WP_SUBSCRIBER_PASSWORD --allow-root
    wp theme install twentyseventeen --activate --allow-root
    wp post delete $(wp post list --format=ids --allow-root) --allow-root
    wp post create --post_type=post --post_title="Hello Inception!" --post_content="lol" --post_status=publish --allow-root

    wp config set WP_REDIS_HOST redis --allow-root
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --force --allow-root --path=/var/www/html

    echo "WordPress setup completed."

    touch $lock_file
else
    echo "WordPress setup has already been run, skipping..."
fi

exec php-fpm7.4 -F
