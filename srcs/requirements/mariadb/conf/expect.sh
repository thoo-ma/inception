#!/usr/bin/expect

set timeout 1
spawn mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "\n"

expect "Switch to unix_socket authentication \[Y/n\]"
send "n\n"

expect "Set root password? \[Y/n\]"
send "y\n"

expect "New password:"
send "root_password\n"

expect "Re-enter new password:"
send "root_password\n"

expect "Remove anonymous users? \[Y/n\]"
send "y\n"

expect "Disallow root login remotely? \[Y/n\]"
send "y\n"

expect "Remove test database and access to it? \[Y/n\]"
send "y\n"

expect "Reload privilege tables now? \[Y/n\]"
send "y\n"

expect eof
