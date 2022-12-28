FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    expect \
    lsof \
    net-tools \
    mariadb-common \
    mariadb-server \
    procps \
    tree \
    vim

RUN mkdir -p /run/mysqld && \
    touch /run/mysqld/mysqld.sock && \
    chown -R mysql:mysql /run/mysqld/

COPY tools/* /scripts/
RUN chmod +x /scripts/*

ARG mysql_root_password
ARG	mysql_user_name
ARG	mysql_user_pass
ARG	mysql_debug
ARG db_name

RUN export MYSQL_ROOT_PASSWORD=$mysql_root_password \
		   MYSQL_USER_NAME=$mysql_user_name \
		   MYSQL_USER_PASS=$mysql_user_pass \
           MYSQL_DEBUG=$mysql_debug \
           DB_NAME=$db_name \
           && ./scripts/configure.sh

ENTRYPOINT ["mysqld", "--user=mysql", "--bind-address=0.0.0.0"]
