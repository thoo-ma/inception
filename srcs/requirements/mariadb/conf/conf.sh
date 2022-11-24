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
sleep 15

# Run mysql_secure_installation
./scripts/secure_mysql_installation.sh

# Ensure that mysql server is running
mysqladmin version

# Just to see mandatory databases (`mysql`, `information_schema`, etc.)
mysqlshow

# TODO Create inception database 

# Grant remote acces to wordpress container
# TODO use .env variables (for password and hostname)
# TODO add user called trobin into wordpress container
#mysql --user="root" \
#      --execute "use mysql; \
#                 GRANT ALL ON *.* to 'root'@'wordpress' IDENTIFIED BY 'pass'; \
#                 FLUSH PRIVILEGES;"

#mysql --user="root" \
#      --execute "CREATE DATABASE inception; \
#                 GRANT ALL ON inception to 'root'@'wordpress' IDENTIFIED BY 'pass'; \
#                 FLUSH PRIVILEGES;"

# -----------------------------------------------------------------------------

# TODO

# Setup `ed25519` authentication plugin
# (Hoping that, while logged as root on server/daemon host machine,
# i.e. mariadb container, trying to connect with
# `mysql -u root -p` with wrong password won't let us get in !...)

# change mysql root user name

# -----------------------------------------------------------------------------
