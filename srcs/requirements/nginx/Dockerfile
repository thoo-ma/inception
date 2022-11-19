# todo: use env variables

FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

# note that into `/etc/nginx/nginx.conf`, http context has
# the following directive: include /etc/nginx/conf.d/*.conf
COPY conf/nginx.conf /etc/nginx/conf.d

#RUN chown -R nginx:nginx /var/www;

# cf. https://stackoverflow.com/a/23038211
RUN openssl req \
    -x509 \
    -nodes \
    -sha256 \
    -days 365 \
    -newkey rsa:4096 \
    -out /etc/ssl/certs/trobin.42.fr.crt \
    -keyout /etc/ssl/private/trobin.42.fr.key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=trobin/CN=trobin.42.fr/"

# cf. https://stackoverflow.com/questions/22111060/
EXPOSE 443

RUN mkdir -p /home/trobin/data/www
RUN echo "<!doctype html>\n<head></head>\n<body>yo</body>" > /home/trobin/data/www/index.html

# RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
# CMD ["nginx"]

CMD ["nginx", "-g", "daemon off;"]
# ENTRYPOINT ["nginx", "-g", "daemon off;"]
