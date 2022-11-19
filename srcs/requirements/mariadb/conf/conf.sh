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
sleep 12

# Run mysql_secure_installation
./scripts/secure_mysql_installation.sh

# Ensure that mysql server is running
mysqladmin version

# Just to see mandatory databases (`mysql`, `information_schema`, etc.)
mysqlshow

# Setup `ed25519` authentication plugin
# (Hoping that, while logged as root on host machine, trying to connect with
# `mysql -u root -p` with wrong password won't let us get in !...)

# change mysql root user name

# -----------------------------------------------------------------------------
