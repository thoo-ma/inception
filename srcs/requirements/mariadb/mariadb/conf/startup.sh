#!/bin/bash

#service mysql status
#mysqld --user=mysql &
#sleep 2
#service mysql status

service mysql start

mysql_secure_installation <<EOF

y
root_password
root_password
y
y
y
y
EOF

service mysql stop

#exec mysqld --user=mysql --console
