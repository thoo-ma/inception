#!/bin/bash

# -----------------------------------------------------------------------------

# start mysql server with mysql host user (cf. top)
mysqld --user=mysql &

# run mysql_secure_installation (which add a password to mysql root user)
./expect.sh

# setup `ed25519` authentication plugin
# (Hoping that, while logged as root on host machine, trying to connect with
# `mysql -u root -p` with wrong password won't let us get in !...)

# change mysql root user name

# -----------------------------------------------------------------------------
