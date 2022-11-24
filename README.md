## Ressources

### LEMP

[About docker-compose LEMP](https://tech.osteel.me/posts/docker-for-local-web-development-part-1-a-basic-lemp-stack)

[overview](https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a)

### nginx

[configure nginx https server](https://nginx.org/en/docs/http/configuring_https_servers.html)

### wordpress

### Docker

[containers best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

[docker-curriculum](https://docker-curriculum.com/)

[docker-compose-viz](https://github.com/pmsipilot/docker-compose-viz)

[awesome compose](https://github.com/docker/awesome-compose)

[changing location of docker volumes](https://dbafromthecold.com/2018/05/02/changing-the-location-of-docker-named-volumes/)

[Docker videos on 42 intranet](https://elearning.intra.42.fr/searches/search?query=docker)

### mariadb/mysql

[Mysql Authentication](https://mariadb.com/kb/en/authentication-plugin-unix-socket/)

[Mariadb versions](https://endoflife.date/mariadb)

[Mysql versions](https://endoflife.date/mysql)

[Mysql best practices](https://docstore.mik.ua/orelly/weblinux2/orn/mysql_tips.html)

[Mysql bind-address into Docker container](http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/)

[SQL videos on 42 intranet](https://elearning.intra.42.fr/searches/search?query=sql)

[About mariadb.sys user](https://www.thegeekdiary.com/what-is-the-purpose-of-mysql-syslocalhost-user/)

## To do on host machine before anything else

1. add `127.0.0.1 localhost trobin.42.fr` to `/etc/hosts`

2. put some `index.html` into `/home/trobin/data/www`

3. use docker without sudo (optionnal)

```
sudo groupadd docker && \
sudo usermod -aG docker $USER && \
newgrp docker
```

## Useful commands

List all mysql users: `SELECT User, Host, Password FROM mysql.user;`
List all mysql databases: `SHOW DATABASES;`
List all listening ports: `netstat -tulpn | grep LISTEN`
