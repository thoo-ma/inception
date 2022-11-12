[overview](https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a)

[containers best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

[configure nginx https server](https://nginx.org/en/docs/http/configuring_https_servers.html)

[docker-curriculum](https://docker-curriculum.com/)

1. add `127.0.0.1 localhost trobin.42.fr` to `/etc/hosts`

2. put some `index.html` into `/home/trobin/data/www`

3. use docker without sudo (optionnal)

```
sudo groupadd docker && \
sudo usermod -aG docker $USER && \
newgrp docker
```

