#!/bin/bash

useradd -m ftpuser && echo "ftpuser:$FTP_PASSWORD" | chpasswd
chown -R ftpuser:ftpuser /var/www/html
mkdir -p /var/run/vsftpd/empty

echo "vsftpd setup finished"

exec /usr/sbin/vsftpd /etc/vsftpd.conf