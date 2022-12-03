#!/bin/bash

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
if ! mysqlshow | grep inception ; then
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD --execute "CREATE DATABASE inception; \
    GRANT ALL PRIVILEGES ON inception.* to 'root'@'wordpress.inception' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
    FLUSH PRIVILEGES;"
fi

# TODO
# Setup `ed25519` authentication plugin
# change mysql root user name
# (?) mysqld --user=mysql -s stop
