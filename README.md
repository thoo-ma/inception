## Useful ressources

#### lemp

[LEMP with docker-compose](https://tech.osteel.me/posts/docker-for-local-web-development-part-1-a-basic-lemp-stack)

#### nginx

[Configure nginx https server](https://nginx.org/en/docs/http/configuring_https_servers.html)

[Configure nginx for serving wordpress](https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/)

#### wordpress

#### docker

[docker-curriculum](https://docker-curriculum.com/)

[Containers best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

#### mariadb/mysql

[Mysql post-installation](https://dev.mysql.com/doc/refman/8.0/en/postinstallation.html)

[Mysql Authentication](https://mariadb.com/kb/en/authentication-plugin-unix-socket/)

[Mysql best practices](https://docstore.mik.ua/orelly/weblinux2/orn/mysql_tips.html)

[Mysql bind-address into Docker container](http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/)

[About mariadb.sys user](https://www.thegeekdiary.com/what-is-the-purpose-of-mysql-syslocalhost-user/)

[About authentication](https://dba.stackexchange.com/a/209520)

[Mysql versions](https://endoflife.date/mysql)

[Mariadb versions](https://endoflife.date/mariadb)

## On host machine

#### Access wordpress from domaine name

```
echo '127.0.0.1 localhost trobin.42.fr' >> '/etc/hosts'
```

N.B.: `/etc/hosts` equivalent on Windows is `C:\Windows\System32\drivers\etc\hosts`

#### Use docker without sudo

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

## Security concerns

Environment variables are not recommended to store any sentive data.
They can be retrieved both from inside the container (running a simple `env` command) and from outside, on host machine where images are build and deployed, with `docker inspect`.

Docker build arguments are not more recommended to store any sensitive data.
They cannot be retrieved from a runnig container, but still from host machine where images are build and deployed, with `docker history`.
