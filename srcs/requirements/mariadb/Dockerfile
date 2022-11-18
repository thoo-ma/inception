From debian:buster

# -------- Documentation ----------------------------------------------------- #

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

# -------- Installation ------------------------------------------------------ #

RUN apt-get update
RUN apt-get install -y expect
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y tree
#RUN apt-get install -y apt-utils

# /!\ LTS FTW /!\
# By default, mariadb-server apt package will refer to version 10.3
# We add mariadb apt repository to install instead mariadb LTS (10.6)
# Anyway both replicate mysql 5.7 (cf. https://mariadb.com/kb/en/mariadb-vs-mysql-compatibility)
# For more information about this whole apt thing, how this script behaves and what are the consequences see:
# - https://mariadb.com/kb/en/mariadb-package-repository-setup-and-usage/
# - https://mariadb.com/kb/en/mariadb-package-repository-setup-and-usage/#platform-specific-behavior-on-debian-and-ubuntu
# - https://mariadb.com/kb/en/differences-in-mariadb-in-debian-and-ubuntu/
RUN curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup \
  | bash -s -- --mariadb-server-version="mariadb-10.6"
RUN apt-get install -y mariadb-common mariadb-server mariadb-client # do we really need mariadb-client ?

# -------- Configuration ----------------------------------------------------- #

# Why this is not automatically created ? And is it still useful since
# we will switch from `unix socket` to `ed25519` authentication plugin ?
RUN mkdir -p /run/mysqld/
RUN touch /run/mysqld/mysqld.sock
RUN chmod -R 777 /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

# TODO
# cf. https://mariadb.com/kb/en/authentication-plugin-ed25519/
# cf. https://mariadb.com/kb/en/authentication-plugin-unix-socket/
# rename mysql root user

# WORKDIR /etc/mysql/mariadb.conf.d
# ARG server_config=50-server.cnf

# Will setup few things here (`mysql_install_db` would also be an option)
ARG server_config=/etc/mysql/mariadb.conf.d/50-server.cnf

# mysql server/daemon will _always_ start from mysql host user
RUN sed -ie 's/^#user\s*=\s*mysql/user = mysql/' $server_config

# Add ed25519 authentication plugin
RUN sed -ie '/^\[mariadb\]$/a plugin_load_add = auth_ed25519' $server_config

# Remove unix socket authentication plugin
RUN sed -ie '/^\[mariadb\]$/a disable_unix_socket' $server_config

# ??
RUN sed -ie 's/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' $server_config

# /!\ DELETE /!\
# For security concern, mysql server should not be started by the host root user.
# The prefered user to do so is the mysql host user.
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

# More config with this script (add mysql root password with few other things)
COPY conf/* /scripts/
RUN chmod +x /scripts/*.sh
# RUN ./scripts/mysql_secure_installation.sh

# -------- Testing ----------------------------------------------------------- #

# Ensure that mysql server is running
#RUN mysqladmin version # equivalent to `service mysql status`

# Just to see mandatory databases (`mysql`, `information_schema`, etc.)
#RUN mysqlshow

# Create the database
#RUN mkdir -p /home/trobin/data/mariadb
#RUN chown -R mysql:mysql /home/trobin/data/mariadb
#RUN mysql -e "CREATE DATABASE inception"

# -------- Network ----------------------------------------------------------- #

#EXPOSE 3306

# -------- Entrypoint -------------------------------------------------------- #

# Start mysql server as process 1 (IS IT A GOOD IDEA ?...)
# CMD ["mysqld", "--user=mysql", "&"]
# CMD ["bash", "scripts/startup.sh"]
