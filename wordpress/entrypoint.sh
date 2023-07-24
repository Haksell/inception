#!/bin/bash

cd /var/www/html

wp core download --allow-root

rm -f /var/www/html/wp-config.php
wp config create --dbname=mariadb --dbhost=mariadb --dbuser=root --dbpass=wordpress --allow-root --skip-check

until wp db check --path=/var/www/html --quiet --allow-root; do
    echo "Waiting for MySQL..."
    sleep 1
done

wp core install --url="axbrisse.42.fr" --title="Ooooh very googoo gaga" --admin_user="axbrisse" --admin_password="axbrisse" --admin_email="axbrisse@student.42.fr" --allow-root

# Add a new user with the role of subscriber
wp user create utenret utenret@example.com --role=subscriber --user_pass=utenret --allow-root

# Change the theme to twenty seventeen
wp theme install twentyseventeen --activate --allow-root

wp post delete $(wp post list --post_type='post' --field=ID --post_title='Hello World' --allow-root)
# Create a new blog post
# TODOcreate only if not exists
wp post create --post_type=post --post_title="Hello Inception!" --post_content="lol" --post_status=publish --allow-root

php-fpm7.4 -F
