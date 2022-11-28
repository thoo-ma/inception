#!/bin/bash

# -----------------------------------------------------------------------------

# Start mysql server with mysql host user
mysqld --user=mysql &

# Waiting for mysql server/daemon to be started.
# Yes, this is dirty.
# More suitable solution would be:
# ```
# PID=$!
# wait $PID
# ```
# Unfortunately, previous command never ends ! (Server is started though.)
sleep 20

# Run mysql_secure_installation
./scripts/secure_mysql_installation.sh

# Ensure that mysql server is running
# mysqladmin version

# Create inception database if not already done
# TODO use .env variables (for password and hostname)
# TODO add user called trobin into wordpress container
# TODO substitute 'wordpress' to 'localhost'
if ! mysqlshow | grep inception ; then
    mysql --user=root --password=$(MYSQL_ROOT_PASSWORD) --execute "CREATE DATABASE inception;"
#    GRANT ALL PRIVILEGES ON inception.* to 'root'@'localhost' IDENTIFIED BY '$(MYSQL_ROOT_PASSWORD)'; \
#    FLUSH PRIVILEGES;"
fi

# ??
# mysqld --user=mysql -s stop

# -----------------------------------------------------------------------------

# TODO

# Setup `ed25519` authentication plugin
# (Hoping that, while logged as root on server/daemon host machine,
# i.e. mariadb container, trying to connect with
# `mysql -u root -p` with wrong password won't let us get in !...)

# change mysql root user name

# -----------------------------------------------------------------------------
