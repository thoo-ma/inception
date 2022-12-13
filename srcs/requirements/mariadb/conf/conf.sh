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
# TODO remove root access
if ! mysqlshow | grep inception ; then
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD --execute "CREATE DATABASE inception; \
    CREATE USER 'trobin'@'wordpress.inception' IDENTIFIED BY 'trobin'; \
    GRANT ALL PRIVILEGES ON inception.* to 'trobin'@'wordpress.inception' IDENTIFIED BY 'trobin'; \
    FLUSH PRIVILEGES; \
    GRANT ALL PRIVILEGES ON inception.* to 'root'@'wordpress.inception' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; \
    FLUSH PRIVILEGES;"
fi

# TODO
# Setup `ed25519` authentication plugin
# change mysql root user name
# (?) mysqld --user=mysql -s stop
