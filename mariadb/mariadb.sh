#!/bin/sh

for i in /scripts/pre-init.d/*sh
do
	echo "script: $i"
	if [ -e "${i}" ]; then
		echo "[i] pre-init.d - processing $i"
		. "${i}"
	fi
done

if [ -d "/run/mysqld" ]; then
	echo "[i] mysqld already present, skipping creation"
	chown -R mysql:mysql /run/mysqld
else
	echo "[i] mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	echo "[i] MySQL directory already present, skipping creation"
	chown -R mysql:mysql /var/lib/mysql
else
	echo "[i] MySQL data directory not found, creating initial DBs"
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	cat < /scripts/init.sql > $tfile

	if [ "$MYSQL_DATABASE" != "" ]; then
	    echo "[i] Creating database: $MYSQL_DATABASE"
		if [ "$MYSQL_CHARSET" != "" ] && [ "$MYSQL_COLLATION" != "" ]; then
			echo "[i] with character set [$MYSQL_CHARSET] and collation [$MYSQL_COLLATION]"
			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET $MYSQL_CHARSET COLLATE $MYSQL_COLLATION;" >> $tfile
		else
			echo "[i] with character set: 'utf8' and collation: 'utf8_general_ci'"
			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
		fi

		if [ "$MYSQL_USER" != "" ]; then
			echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
			echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
		fi
	fi

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
	rm -f $tfile

	if [ "$MYSQL_DATABASE" != "" ] && [ "$(ls -A /docker-entrypoint-initdb.d 2>/dev/null)" ]; then
        echo
        echo "Preparing to process the contents of /docker-entrypoint-initdb.d/"
        echo
		TEMP_OUTPUT_LOG=/tmp/mysqld_output
		/usr/bin/mysqld --user=mysql --skip-name-resolve --skip-networking=0 --silent-startup > "${TEMP_OUTPUT_LOG}" 2>&1 &
		PID="$!"

		until tail "${TEMP_OUTPUT_LOG}" | grep -q "Version:"; do
			sleep 0.2
		done

		MYSQL_CLIENT="/usr/bin/mysql -u root -p$MYSQL_ROOT_PASSWORD"

		for f in /docker-entrypoint-initdb.d/*; do
			case "$f" in
				*.sql)    echo "  $0: running $f"; eval "${MYSQL_CLIENT} ${MYSQL_DATABASE} < $f"; echo ;;
				*.sql.gz) echo "  $0: running $f"; gunzip -c "$f" | eval "${MYSQL_CLIENT} ${MYSQL_DATABASE}"; echo ;;
			esac
		done

    	kill -s TERM "${PID}"
    	wait "${PID}"
        rm -f TEMP_OUTPUT_LOG
    	echo "Completed processing seed files."
	fi;

	echo
	echo 'MySQL init process done. Ready for start up.'
	echo

	echo "exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0" "$@"
fi

for i in /scripts/pre-exec.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-exec.d - processing $i"
		. ${i}
	fi
done

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@