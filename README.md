## On host machine

##### Access wordpress from domaine name

```
echo '127.0.0.1 localhost trobin.42.fr' >> '/etc/hosts'
```

N.B.: `/etc/hosts` equivalent on Windows is `C:\Windows\System32\drivers\etc\hosts`

##### Use docker without sudo

```
sudo groupadd docker && \
sudo usermod -aG docker $USER && \
newgrp docker
```

## Useful commands

List all mysql users: `SELECT User, Host, Password FROM mysql.user;`

List all mysql databases: `SHOW DATABASES;`

List all listening ports: `netstat -tulpn | grep LISTEN`

Show user grants: `SHOW GRANTS FOR 'username'@'hostname';`

Connect to nginx service from host machine: `curl -k https://localhost`

Connect to nginx service from other service: `curl -k https://nginx`

Display user and host for current mysql session: `mysql> select user();`

Display data stored into a table: `SELECT * FROM table_name;`

Access wordpress administration dashboard: `https://example.com/wp-admin`

Ensure that mysql server is running: `mysqladmin version`

Get wordpress IP address from mariadb container: `ping wordpress | head -1 | awk -F '[()]' '{print $2}'`

List wordpress comments: `wp comment list`

Approve wordpress comment: `wp comment approve comment_id`

Acess wordpress admin dashboard: `https://trobin.42.fr/wp-admin`

## Useful files/directories

nginx logs: `/var/log/nginx/access.log` and `/var/log/nginx/error.log`

## Security concerns

Environment variables are not recommended to store any sentive data.
They can be retrieved both from inside the container (running a simple `env` command) and from outside, on host machine where images are build and deployed, with `docker inspect`.

Docker build arguments are not more recommended to store any sensitive data.
They cannot be retrieved from a runnig container, but still from host machine where images are build and deployed, with `docker history`.

## Useful ressources

#### Docker

[docker-curriculum](https://docker-curriculum.com/)

[Containers best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

[Understanding and hardening Linux containers](https://www.nccgroup.com/globalassets/our-research/us/whitepapers/2016/april/ncc_group_understanding_hardening_linux_containers-1-1.pdf)

#### Docker-compose

##### restart

[restart](https://github.com/compose-spec/compose-spec/blob/master/spec.md#restart)

[restart_policy](https://github.com/compose-spec/compose-spec/blob/master/deploy.md#restart_policy)

[restart_policy details](https://docs.docker.com/config/containers/start-containers-automatically/#restart-policy-details)

[restart policy and docker stop/kill](https://serverfault.com/a/884823)

##### depends_on

[depends_on](https://github.com/compose-spec/compose-spec/blob/master/spec.md#depends_on)

[healthcheck](https://github.com/compose-spec/compose-spec/blob/master/spec.md#healthcheck)

##### network

[networking in compose](https://docs.docker.com/compose/networking/)

[ports](https://docs.docker.com/compose/compose-file/compose-file-v3/#ports)

[expose](https://docs.docker.com/compose/compose-file/compose-file-v3/#expose)

[expose vs ports](https://www.baeldung.com/ops/docker-compose-expose-vs-ports)

##### env

[env variables in compose](https://docs.docker.com/compose/environment-variables/)

[env_file](https://docs.docker.com/compose/compose-file/compose-file-v3/#env_file)

##### secrets (not needed _at all_ by the subject)

[secrets without swarm](https://www.rockyourcode.com/using-docker-secrets-with-docker-compose/)

#### Nginx

[Configure nginx https server](https://nginx.org/en/docs/http/configuring_https_servers.html)

[Configure nginx for serving wordpress](https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/)

#### Mariadb/Mysql

[Mysql post-installation](https://dev.mysql.com/doc/refman/8.0/en/postinstallation.html)

[Mysql Authentication](https://mariadb.com/kb/en/authentication-plugin-unix-socket/)

[Mysql best practices](https://docstore.mik.ua/orelly/weblinux2/orn/mysql_tips.html)

[Mysql bind-address into Docker container](http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/)

[About mariadb.sys user](https://www.thegeekdiary.com/what-is-the-purpose-of-mysql-syslocalhost-user/)

[About authentication](https://dba.stackexchange.com/a/209520)

[Mysql versions](https://endoflife.date/mysql)

[Mariadb versions](https://endoflife.date/mariadb)
