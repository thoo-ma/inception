#!/bin/bash

function comment   () { sed -i "/$2/s/^/#/g" $1; }
function uncomment () { sed -i "/$2/s/^#//g" $1; }

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

# Debug mode
if [ ! -z $MYSQL_DEBUG ] ; then
    server_config='/etc/mysql/mariadb.conf.d/50-server.cnf'
    uncomment $server_config 'general_log'
    uncomment $server_config 'log_error'
	sed -i '/^\[mariadb\]/a log_warnings=4' $server_config
fi

# Create inception database if not already done
if ! mysqlshow | grep $DB_NAME ; then
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD --execute "CREATE DATABASE $DB_NAME; \
    CREATE USER '$MYSQL_USER_NAME'@'wordpress.inception' IDENTIFIED BY '$MYSQL_USER_PASS'; \
    GRANT ALL PRIVILEGES ON $DB_NAME.* to '$MYSQL_USER_NAME'@'wordpress.inception' IDENTIFIED BY '$MYSQL_USER_PASS'; \
    FLUSH PRIVILEGES;"
fi
