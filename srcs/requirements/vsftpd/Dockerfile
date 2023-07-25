FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd

EXPOSE 20-21
EXPOSE 30000-30009

COPY vsftpd.conf /etc/vsftpd.conf
COPY vsftpd.sh /vsftpd.sh
RUN chmod +x /vsftpd.sh
ENTRYPOINT ["/vsftpd.sh"]
