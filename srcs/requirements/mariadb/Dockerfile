From debian:buster

# -------- Documentation ----------------------------------------------------- #

# mysql
# cf. https://dev.mysql.com/doc/refman/8.0/en/postinstallation.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/changing-mysql-user.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/server-options.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html

# Authentication
# cf. https://dba.stackexchange.com/a/209520

# Miscellaneous
# cf. https://docs.docker.com/storage/volumes/
# cf. http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/

# -------- Installation ------------------------------------------------------ #

RUN apt-get update
RUN apt-get install -y expect
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y tree
RUN apt-get install -y tree
#RUN apt-get install -y net-tools # netstat
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

# https://mariadb.com/kb/en/plugin-overview/#installing-a-pluginhttps://mariadb.com/kb/en/plugin-overview/#installing-a-plugin
# RUN apt-get install -y libmysqlclient18

# -------- Configuration ----------------------------------------------------- #

# Why this is not automatically created ? And is it still useful since
# we will switch from `unix socket` to `ed25519` authentication plugin ?
RUN mkdir -p /run/mysqld/
RUN touch /run/mysqld/mysqld.sock
RUN chmod -R 777 /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

# WORKDIR /etc/mysql/mariadb.conf.d
# ARG server_config=50-server.cnf

# Will setup few things here (`mysql_install_db` would also be an option)
ARG server_config=/etc/mysql/mariadb.conf.d/50-server.cnf

# mysql server/daemon will _always_ start from mysql host user
RUN sed -i -e 's/^#user\s*=\s*mysql/user = mysql/' $server_config

# Add ed25519 authentication plugin
# cf. https://mariadb.com/kb/en/authentication-plugin-ed25519/
# cf. https://mariadb.com/kb/en/authentication-plugin-unix-socket/
# RUN sed -i -e '/^\[mariadb\]$/a plugin_load_add = auth_ed25519' $server_config
# RUN sed -i -e '/^\[mariadb\]$/a plugin_load_add = client_ed25519' $server_config

# Disable unix socket authentication plugin (don't uninstall)
# Commands like `mysqladmin version` or `service mariadb status` won't be available anymore...
#RUN sed -i -e '/^\[mariadb\]$/a disable_unix_socket' $server_config

# For mysql server/daemon to be accessible from anywhere (not only localhost i.e. this container)
RUN sed -i -e 's/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' $server_config

# /!\ DELETE /!\
# RUN cat /etc/passwd | grep mysql | awk -F ':' '{ print $7 }'
# RUN usermod --shell /bin/bash mysql
# RUN cat /etc/passwd | grep mysql | awk -F ':' '{ print $7 }'

# More config with this script
COPY conf/* /scripts/
RUN chmod +x /scripts/*.sh
RUN ./scripts/conf.sh

# -------- Network ----------------------------------------------------------- #

# cf. https://stackoverflow.com/questions/22111060/
EXPOSE 3306

# -------- Entrypoint -------------------------------------------------------- #

# CMD ["mysqld", "--log-bin=mysqld-bin"]
ENTRYPOINT ["mysqld"]
#ENTRYPOINT ["mysqld", "--log-bin=mysqld-bin"]
