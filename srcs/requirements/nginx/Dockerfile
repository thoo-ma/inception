FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    curl \
    gettext \
    lsof \
    net-tools \
    nginx \
    openssl \
    procps \
    vim

ARG domain_name
ARG ssl_crt
ARG ssl_key

# Generate nginx.conf from template (cf. https://stackoverflow.com/a/57891894d)
# This is to allow environment variables into (template) config file
COPY conf/nginx.conf.template /tmp/nginx.conf.template
RUN export DOMAIN_NAME=$domain_name \
    && export SSL_CERTIFICATE=$ssl_crt \
    && export SSL_CERTIFICATE_KEY=$ssl_key \
    && envsubst '$DOMAIN_NAME $SSL_CERTIFICATE $SSL_CERTIFICATE_KEY' \
    < /tmp/nginx.conf.template > /etc/nginx/conf.d/nginx.conf

# Doesn't change permissions upon `var/www/inception` because
# the volume is mounted at the very end of the build process.
# (It doesn't even exist at this point.)
RUN chown -R www-data:www-data /var/www;

# cf. https://stackoverflow.com/a/23038211
RUN openssl req \
    -x509 \
    -nodes \
    -sha256 \
    -days 365 \
    -newkey rsa:4096 \
    -out $ssl_crt \
    -keyout $ssl_key \
    -subj "/C=FR/ST=Paris/L=Paris/O=42Paris/OU=trobin/CN=$domain_name/"

# HTTP will pass through port 9000 instead of 80
RUN sed -i 's/80/9000/' /etc/nginx/sites-enabled/default

ENTRYPOINT ["nginx", "-g", "daemon off;"]
