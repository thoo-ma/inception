FROM debian:buster

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y vim # ??
RUN apt-get install -y curl # ??
RUN apt-get install -y less # needed by wp-cli (https://github.com/wp-cli/wp-cli/issues/5333)
RUN apt-get install -y lsb-release # ??
RUN apt-get install -y ca-certificates # ??
RUN apt-get install -y apt-transport-https # ??
RUN apt-get install -y mariadb-client
RUN apt-get install -y net-tools # netstat
RUN apt-get install -y lsof # ??

# Install php8.1 (LTS)
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y php8.1
RUN apt-get install -y php8.1-fpm
RUN apt-get install -y php8.1-curl # ??
RUN apt-get install -y php8.1-mysql
RUN apt-get install -y sendmail # needed by wordpress config

# Download wp-cli (OS-agnostic way)
WORKDIR /tmp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

ARG db_host \
	db_name \
    db_user \
    db_pass \
    db_prefix \
    wp_url \
    wp_title \
    wp_debug \
    wp_admin_user \
    wp_admin_pass \
    wp_admin_mail

ENV	DB_HOST=$db_host \
	DB_NAME=$db_name \
	DB_USER=$db_user \
	DB_PASS=$db_pass \
	DB_PREFIX=$db_prefix \
    WP_URL=$wp_url \
    WP_TITLE=$wp_title \
    WP_DEBUG=$wp_debug \
    WP_ADMIN_USER=$wp_admin_user \
    WP_ADMIN_PASS=$wp_admin_pass \
    WP_ADMIN_MAIL=$wp_admin_mail

RUN useradd trobin # MYSQL_USER_NAME
RUN mkdir /home/trobin
RUN chown trobin:trobin /home/trobin

COPY conf/configure.sh /scripts/configure.sh
RUN mkdir -p /run/php
RUN touch /run/php/php8.1-fpm.pid
RUN touch /var/log/php8.1-fpm.log
RUN chown trobin:trobin /run/php/php8.1-fpm.pid
RUN chown trobin:trobin /var/log/php8.1-fpm.log
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini
RUN sed -i -e 's/^listen\s*=\s*\/run\/php\/php8.1-fpm.sock/listen = 9000/' /etc/php/8.1/fpm/pool.d/www.conf
RUN chown trobin:trobin /scripts/configure.sh
# RUN mkdir -p /var/www/inception/public_html
# RUN chown -R trobin:trobin /var/www/inception
USER trobin
RUN chmod +x /scripts/configure.sh
RUN chmod 755 /run/php/php8.1-fpm.pid
RUN chmod 755 /var/log/php8.1-fpm.log

WORKDIR /var/www/inception/public_html
ENTRYPOINT ["/scripts/configure.sh"]
