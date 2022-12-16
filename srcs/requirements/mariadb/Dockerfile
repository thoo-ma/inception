From debian:buster

# -------- Documentation ----------------------------------------------------- #

# mysql
# cf. https://dev.mysql.com/doc/refman/8.0/en/postinstallation.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/changing-mysql-user.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/server-options.html
# cf. https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html
# cf. http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/

# Authentication
# cf. https://dba.stackexchange.com/a/209520

# -------- Installation ------------------------------------------------------ #

RUN apt-get update
RUN apt-get install -y expect
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y tree # remove
RUN apt-get install -y net-tools # netstat
RUN apt-get install -y lsof
#RUN apt-get install -y apt-utils

# RUN apt-get install -y expect vim curl ca-certificates tree net-tools lsof

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
RUN chmod -R 777 /run/mysqld # ??
RUN chown -R mysql:mysql /run/mysqld

# Enable ed25519 authentication plugin (already installed at `/usr/lib/mysql/plugin/`)
# cf. https://mariadb.com/kb/en/authentication-plugin-ed25519/
# cf. https://mariadb.com/kb/en/authentication-plugin-unix-socket/
# RUN sed -i -e '/^\[mariadb\]$/a plugin_load_add = auth_ed25519' $server_config
# RUN sed -i -e '/^\[mariadb\]$/a plugin_load_add = client_ed25519' $server_config

# Disable unix socket authentication plugin (don't uninstall)
# Commands like `mysqladmin version` or `service mariadb status` won't be available anymore...
# RUN sed -i -e '/^\[mariadb\]$/a disable_unix_socket' $server_config

COPY conf/* /scripts/
RUN chmod +x /scripts/*

ARG mysql_root_password \
	mysql_user_name \
	mysql_user_pass \
	mysql_debug \
    db_name

RUN export MYSQL_ROOT_PASSWORD=$mysql_root_password \
		   MYSQL_USER_NAME=$mysql_user_name \
		   MYSQL_USER_PASS=$mysql_user_pass \
           MYSQL_DEBUG=$mysql_debug \
           DB_NAME=$db_name \
           && ./scripts/configure.sh

# -------- Entrypoint -------------------------------------------------------- #

ENTRYPOINT ["mysqld", "--user=mysql", "--bind-address=0.0.0.0"]
# ENTRYPOINT ["mysqld", "--user=mysql", "--bind-address=0.0.0.0", "--log-bin=mysqld-bin"]
