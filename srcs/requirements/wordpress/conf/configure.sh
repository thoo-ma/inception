#!/bin/bash

# The following commands _need_ to be performed into an antrypoint script
# since they download and edit files into a bind-mounted folder.

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

# Debug mode
if [ ! -z $WP_DEBUG ] ; then
#    theme_functions='/var/www/inception/public_html/wp-content/themes/twentytwentythree/functions.php'
    wp_config='/var/www/inception/public_html/wp-config.php'
	wp config set WP_DEBUG true --raw
	wp config set WP_DEBUG_LOG true --add --raw
	wp config set WP_DEBUG_DISPLAY false --add --raw
#	wp config set WP_HOME "https://$WP_URL" --add
#	wp config set WP_SITEURL "https://$WP_URL" --add
#	echo "update_option( 'siteurl', "https://$WP_URL" );" >> $theme_functions
#	echo "update_option( 'home', "https://$WP_URL" );" >> $theme_functions
	sed -i "/define( 'WP_DEBUG_DISPLAY', false );/a @ini_set( 'display_errors', 0 );" $wp_config
fi

# Unfortunately `-c` option doesn't ignore Dokerfile's ENV variables
exec -c php-fpm8.1 --nodaemonize
