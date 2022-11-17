From debian:buster

# 1. download mysql
# 2. secure installation (following the `mysql_secure_instalation` prompt order)
#     2.1 give password to mysql root user
#     2.2 remove anonymous user
#     2.3 allow mysql root user to connect only from localhost
#     2.4 remove test database
# 3. setup missing files and repositories
# 4. start mysql server/daemon (`mysql` and not `mysqld` on debian) with mysql host OS user

# mysql doc
# cf. https://dev.mysql.com/doc/refman/8.0/en/postinstallation.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/changing-mysql-user.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/server-options.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html

# Authentification
# cf. https://dba.stackexchange.com/a/209520

# En vrac
# cf. https://docs.docker.com/storage/volumes/
# cf. http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/

RUN apt-get update
RUN apt-get install -y mariadb-common mariadb-server mariadb-client
#RUN apt-get install -y apt-utils
RUN apt-get install -y expect
RUN apt-get install -y vim

# Why this is not automatically created ?
# Seems to be related to `systemd` and `INSTALL_LAYOUT` (cf. `DSYSTEMD_PID_DIR`)
RUN mkdir -p /var/run/mysqld/
RUN touch /var/run/mysqld/mysqld.sock
RUN chmod -R 777 /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

# ??
RUN cat /etc/mysql/mariadb.conf.d/50-server.cnf | grep bind-address; exit 0
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN cat /etc/mysql/mariadb.conf.d/50-server.cnf | grep bind-address; exit 0

# mysql secure installation
# RUN mkdir -p /scripts
# COPY conf/mysql_secure_installation.sh /scripts
# RUN chmod +x /scripts/mysql_secure_installation.sh
# RUN /scripts/mysql_secure_installation.sh

# For security concern, mysql server should not be started by root user.
# The prefered user to do so is the mysql user.
# This user is created during the mariadb installation performed above.
# However, we can't login with this user since his login shell is `/bin/false'
# (cat /etc/passwd | grep mysql | awk -F ':' '{ print $7 }' )
# Hence, instead of doing `su mysql` we will TRY to do `sudo -u mysql /bin/bash`
# That's why we install the sudo apt package.
# (Yes, while logged as root we still could do something like `mysql --user=mysql`
# BUT here we start the mysql server with `service mysql start`.)
# RUN apt-get install sudo
# RUN cat /etc/passwd | grep mysql | awk -F ':' '{ print $7 }'
# RUN usermod --shell /bin/bash mysql
# RUN cat /etc/passwd | grep mysql | awk -F ':' '{ print $7 }'

# What mariadb installation from `apt` package do for us:
# - create the `mysql` user
# - create and initialize `data directory` at `/var/lib/mysql`
#   (cf. https://dev.mysql.com/doc/refman/8.0/en/data-directory-initialization.html)

# Data directory is automatically created and initialized at `/var/lib/mysql`
# RUN mysql_install_db --user=mysql
# RUN mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

# --- DON'T WORK
# Start the mysql server
# They say using `service mysql start` is not a good idea -- but why ?...
#USER mysql
#RUN mysqld --user=mysql &
#RUN mysqld_safe --user=mysql

# Ensure that mysql server is running
#RUN mysqladmin version # equivalent to `service mysql status`

# Just to see mandatory databases (`mysql`, `information_schema`, etc.)
#RUN mysqlshow

# Create the database
#RUN mkdir -p /home/trobin/data/mariadb
#RUN chown -R mysql:mysql /home/trobin/data/mariadb
#RUN mysql -e "CREATE DATABASE inception"

#EXPOSE 3306

# Start mysql server as process 1 (IS IT A GOOD IDEA ?...)

COPY conf/* /scripts/
RUN chmod +x /scripts/*.sh

#CMD ["mysqld", "--user=mysql"]
# CMD ["bash", "scripts/startup.sh"]
