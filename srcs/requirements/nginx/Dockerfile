FROM alpine:3.17.4

RUN apk add --no-cache nginx openssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem -days 365 -nodes -subj '/CN=axbrisse.42.fr'

RUN rm -f /etc/nginx/conf.d/default.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
