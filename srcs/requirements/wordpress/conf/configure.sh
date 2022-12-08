#!/bin/bash

# ending semicolon is important
function success () { echo "$1: SUCCESS" >> /tmp/log.txt; }
function failure () { echo "$1: FAILURE" >> /tmp/log.txt; }

# Wordpress download
# TODO delete `--allow-root`
if wp core download --allow-root;
	then success "download"
	else failure "download"
fi

# Wordpress config
# TODO delete `--allow-root`
# TODO delete `--force`
if wp core config \
    --dbhost=$DB_HOST \
	--dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASS \
	--dbprefix=$DB_PREFIX \
    --allow-root \
    --force;
	then success "config"
	else failure "config"
fi

# Wordpress install
# TODO delete `--allow-root`
# This take so much time and doesn't block execution flow ...
if wp core install \
	--url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_MAIL \
	--allow-root;
	then success "install"
	else failure "install"
fi

#env > /tmp/env
#unset DB_HOST DB_NAME DB_USER DB_PASS \
#	  WP_URL WP_TITLE WP_ADMIN_USER WP_ADMIN_PASS WP_ADMIN_MAIL

# ?? (related to `include fastcgi_params` into `nginx.conf`)
sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini

# ??
sed -i -e 's/^listen\s*=\s*\/run\/php\/php8.1-fpm.sock/listen = 9000/' /etc/php/8.1/fpm/pool.d/www.conf

# Wordpress update
wp plugin update --all --allow-root

# ??
mkdir -p /run/php

exec php-fpm8.1 --allow-to-run-as-root -F -c /etc/php/8.1/fpm/php.ini
