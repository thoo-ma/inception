#!/usr/bin/expect

# Syntax and order of the questions depends on mariadb version.
# Be careful to edit this file when mariadb version is updated.
# Now this script is compliant with version 10.6 (LTS).

set yes  "y\n"
set no   "n\n"
set enter "\n"
set password "$env(MYSQL_ROOT_PASSWORD)\n"

set timeout 1

spawn mysql_secure_installation

expect "Enter current password for root (enter for none):"  ; send $enter
expect "Switch to unix_socket authentication \[Y/n\]"       ; send $no
expect "Set root password? \[Y/n\]"                         ; send $yes
expect "New password:"                                      ; send $password
expect "Re-enter new password:"                             ; send $password
expect "Remove anonymous users? \[Y/n\]"                    ; send $yes
expect "Disallow root login remotely? \[Y/n\]"              ; send $yes
expect "Remove test database and access to it? \[Y/n\]"     ; send $yes
expect "Reload privilege tables now? \[Y/n\]"               ; send $yes

expect eof
