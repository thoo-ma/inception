all:
	mkdir -p /home/trobin/data/mariadb
	mkdir -p /home/trobin/data/wordpress
	cd srcs && docker compose build

nginx:
	docker build -t nginx /home/trobin/inception/srcs/requirements/nginx \
	&& docker run --detach --publish 443 --name nginx nginx:latest
