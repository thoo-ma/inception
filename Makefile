mariadb_volume		=	/home/trobin/data/mariadb
wordpress_volume	=	/home/trobin/data/wordpress
docker_compose_dir	=	/home/trobin/inception/srcs

all:					volumes
						cd $(docker_compose_dir) \
						&& docker compose build

mariadb_volume:		;	mkdir -p $(mariadb_volume)
wordpress_volume:	;	mkdir -p $(wordpress_volume)
volumes:				mariadb_volume wordpress_volume

mariadb: 				mariadb_volume
						cd $(docker_compose_dir) \
						&& docker compose build mariadb \
						&& docker compose run --name=mariadb mariadb


nginx:					wordpress_volume
						cd $(docker_compose_dir) \
						&& docker compose build nginx \
						&& docker compose run --name=nginx --interactive nginx

wordpress:
						cd $(docker_compose_dir) \
						&& docker compose build wordpress \
						&& docker compose run --name=wordpress --interactive wordpress
