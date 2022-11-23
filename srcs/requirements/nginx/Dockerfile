# todo: use env variables
# curl -k https://trobin.42.fr
# curl -k https://localhost:443

FROM debian:buster

# note some packages are for testing purpose only (curl, procps, vim, lynx)
RUN apt-get update && apt-get install -y nginx openssl curl procps vim # lynx

# note that into `/etc/nginx/nginx.conf`, http context has
# the following directive: include /etc/nginx/conf.d/*.conf
COPY conf/nginx.conf /etc/nginx/conf.d

# What to do with this ?...
# RUN chown -R www-data:www-data /var/www;
# RUN chown -R nginx:nginx /var/www;

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

# Doesn't work cause we not root here
# RUN echo '127.0.0.1 localhost trobin.42.fr' >> /etc/hosts

# On pause for the moment to run in interactive mode (cf. Makefile)
# CMD ["nginx", "-g", "daemon off;"]
# ENTRYPOINT ["nginx", "-g", "daemon off;"]
