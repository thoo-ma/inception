## Ressources

[overview](https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a)

[containers best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

[configure nginx https server](https://nginx.org/en/docs/http/configuring_https_servers.html)

[docker-curriculum](https://docker-curriculum.com/)

[docker-compose-viz](https://github.com/pmsipilot/docker-compose-viz)

[awesome compose](https://github.com/docker/awesome-compose)

[changing location of docker volumes](https://dbafromthecold.com/2018/05/02/changing-the-location-of-docker-named-volumes/)

[About docker-compose LEMP](https://tech.osteel.me/posts/docker-for-local-web-development-part-1-a-basic-lemp-stack)

[Worpress with Docker](https://www.hostinger.fr/tutoriels/docker-wordpress)

[Mysql bind-address into Docker container](http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/)

[SQL videos on 42 intranet](https://elearning.intra.42.fr/searches/search?query=sql)

[Docker videos on 42 intranet](https://elearning.intra.42.fr/searches/search?query=docker)

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

`docker run -it repository:tag`
