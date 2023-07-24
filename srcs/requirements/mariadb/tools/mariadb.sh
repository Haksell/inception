#!/bin/sh

chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
mkdir -p /run/mysqld

if [ -d /var/lib/mysql/mysql ]; then
	echo "MySQL directory already present, skipping creation"
else
	echo "MySQL directory not found, creating database '$DB_NAME'"
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
	tfile=`mktemp`
	echo "USE mysql;" >> "$tfile"
	echo "FLUSH PRIVILEGES ;" >> "$tfile"
	echo "GRANT ALL ON *.* TO 'root'@'%' identified by '$DB_ROOT_PASSWORD' WITH GRANT OPTION ;" >> "$tfile"
	echo "GRANT ALL ON *.* TO 'root'@'localhost' identified by '$DB_ROOT_PASSWORD' WITH GRANT OPTION ;" >> "$tfile"
	echo "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${DB_ROOT_PASSWORD}') ;" >> "$tfile"
	echo "DROP DATABASE IF EXISTS test ;" >> "$tfile"
	echo "FLUSH PRIVILEGES ;" >> "$tfile"
	echo "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> "$tfile"
	echo "GRANT ALL ON \`$DB_NAME\`.* to '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';" >> "$tfile"
	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < "$tfile"
	rm -f "$tfile"
fi

echo 'MariaDB init process done.'
exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@
echo 'MariaDB exec process done. This is bad.'