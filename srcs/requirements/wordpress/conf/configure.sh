#!/bin/bash

# ending semicolon is important
function success () { echo "$1: SUCCESS" >> /tmp/wp.log; }
function failure () { echo "$1: FAILURE" >> /tmp/wp.log; }

# Wordpress download
if wp core download;
	then success "download"
	else failure "download"
fi

# Wordpress config
# TODO (?) delete `--force`
if wp core config \
    --dbhost=$DB_HOST \
	--dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASS \
	--dbprefix=$DB_PREFIX \
    --force;
	then success "config"
	else failure "config"
fi

# Wordpress install
# This take so much time and doesn't block execution flow ...
if wp core install \
	--url=$WP_URL \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASS \
    --admin_email=$WP_ADMIN_MAIL;
	then success "install"
	else failure "install"
fi

# TODO this doesn't work...
# env > /tmp/env
# unset DB_HOST DB_NAME DB_USER DB_PASS \
#	  WP_URL WP_TITLE WP_ADMIN_USER WP_ADMIN_PASS WP_ADMIN_MAIL

# debug
wp config set WP_DEBUG true --raw
wp config set WP_DEBUG_LOG true --add --raw
wp config set WP_DEBUG_DISPLAY false --add --raw
wp config set WP_HOME "https://$WP_URL" --add
wp config set WP_SITEURL "https://$WP_URL" --add
echo "update_option( 'siteurl', "https://$WP_URL" );" >> /var/www/inception/public_html/wp-content/themes/twentytwentythree/functions.php
echo "update_option( 'home', "https://$WP_URL" );" >> /var/www/inception/public_html/wp-content/themes/twentytwentythree/functions.php
sed -i "/define( 'WP_DEBUG_DISPLAY', false );/a @ini_set( 'display_errors', 0 );" /var/www/inception/public_html/wp-config.php

exec php-fpm8.1 --nodaemonize
