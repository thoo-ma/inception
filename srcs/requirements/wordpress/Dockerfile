FROM debian:buster

# Needed to install php (cf. below)
RUN apt-get update && \
    apt-get install -y \
    lsb-release \
    wget

# Yes, those comments are dirty since backticks are not meant
# to be used like this _but_ I wanted to put some comments here.
# TODO remove unneceary packages (lsof, curl, net-tools, vim)
RUN wget --output-document=/etc/apt/trusted.gpg.d/php.gpg \
    https://packages.sury.org/php/apt.gpg &&  \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    less `# needed by wp-cli (https://github.com/wp-cli/wp-cli/issues/5333)` \
    lsof \
    mariadb-client \
    net-tools \
    php8.1 \
    php8.1-curl \
    php8.1-fpm \
    php8.1-mysql \
    sendmail `# needed because '--admin_email' is used by 'wp core install'` \
    vim

# Download wp-cli (OS-agnostic way)
RUN curl \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    --output /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

ARG db_host
ARG	db_name
ARG db_user
ARG db_pass
ARG db_prefix
ARG wp_dir
ARG wp_url
ARG wp_title
ARG wp_debug
ARG wp_admin_user
ARG wp_admin_pass
ARG wp_admin_mail

ENV	DB_HOST=$db_host \
	DB_NAME=$db_name \
	DB_USER=$db_user \
	DB_PASS=$db_pass \
	DB_PREFIX=$db_prefix \
    WP_DIR=$wp_dir \
    WP_URL=$wp_url \
    WP_TITLE=$wp_title \
    WP_DEBUG=$wp_debug \
    WP_ADMIN_USER=$wp_admin_user \
    WP_ADMIN_PASS=$wp_admin_pass \
    WP_ADMIN_MAIL=$wp_admin_mail

COPY tools/entrypoint.sh /scripts/entrypoint.sh

# (?) TODO useradd `--password`
RUN useradd --create-home $db_user && \
	mkdir -p /run/php && \
	touch /run/php/php8.1-fpm.pid && \
	touch /var/log/php8.1-fpm.log && \
	chown $db_user:$db_user /run/php/php8.1-fpm.pid && \
	chown $db_user:$db_user /var/log/php8.1-fpm.log && \
    chown $db_user:$db_user /scripts/entrypoint.sh && \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/^listen\s*=\s*\/run\/php\/php8.1-fpm.sock/listen = 9000/' /etc/php/8.1/fpm/pool.d/www.conf && \
    chmod +x /scripts/entrypoint.sh

USER $db_user

WORKDIR /scripts

ENTRYPOINT ["./entrypoint.sh"]
