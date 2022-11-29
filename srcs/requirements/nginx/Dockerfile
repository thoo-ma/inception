# curl -k https://trobin.42.fr
# curl -k https://localhost:443

FROM debian:buster

ARG domain_name ssl_crt ssl_key

# note some packages are for testing purpose only (curl, procps, vim, lynx)
RUN apt-get update && apt-get install -y nginx openssl curl procps vim gettext # lynx

# Generate nginx.conf from template
# cf. https://stackoverflow.com/a/57891894d
COPY conf/nginx.conf.template /tmp/nginx.conf.template
RUN export DOMAIN_NAME=$domain_name \
    && export SSL_CERTIFICATE=$ssl_crt \
    && export SSL_CERTIFICATE_KEY=$ssl_key \
    && envsubst '$DOMAIN_NAME $SSL_CERTIFICATE $SSL_CERTIFICATE_KEY' \
    < /tmp/nginx.conf.template > /etc/nginx/conf.d/nginx.conf
# COPY conf/nginx.conf /etc/nginx/conf.

# What to do with this ?...
# RUN chown -R www-data:www-data /var/www;
# RUN chown -R nginx:nginx /var/www;

# cf. https://stackoverflow.com/a/23038211
# TODO (?) generate certificate on host machine
RUN openssl req \
    -x509 \
    -nodes \
    -sha256 \
    -days 365 \
    -newkey rsa:4096 \
    -out $ssl_crt \
    -keyout $ssl_key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=trobin/CN=$domain_name/"

# RUN useradd trobin
# USER trobin

# cf. https://stackoverflow.com/questions/22111060/
EXPOSE 443

# Doesn't work cause we not root here
# RUN echo '127.0.0.1 localhost trobin.42.fr' >> /etc/hosts

ENTRYPOINT ["nginx", "-g", "daemon off;"]
