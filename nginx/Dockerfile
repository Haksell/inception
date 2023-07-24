FROM nginx:alpine

RUN apk add --no-cache openssl
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem -days 365 -nodes -subj '/CN=axbrisse.42.fr'

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443