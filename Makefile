mariadb_volume		=	$(HOME)/data/mariadb
wordpress_volume	=	$(HOME)/data/wordpress/public_html
docker_compose_dir	=	$(HOME)/42/inception/srcs

#nginx_volume:		;
nginx_volume:		;	mkdir -p $(wordpress_volume)
mariadb_volume:		;	mkdir -p $(mariadb_volume)
wordpress_volume:	;	mkdir -p $(wordpress_volume)

all: 					volumes
						cd $(docker_compose_dir) \
						&& docker compose up --build --detach

%_up:					%_volume
						cd $(docker_compose_dir) \
						&& docker compose up $* --build --detach

%_it:				;	cd $(docker_compose_dir) \
						&& docker compose exec $* /bin/bash

%_stop:				;	cd $(docker_compose_dir) \
						&& docker compose stop $*

%_log:				;	cd $(docker_compose_dir) \
						&& docker compose logs $*

%_clean:				%_stop
						cd $(docker_compose_dir) \
						&& docker system prune \
						&& docker compose rm $* \
						&& docker volume rm -f inception_$*

fclean:					clean
						docker volume rm -f inception_mariadb
						docker volume rm -f inception_wordpress
						sudo rm -rf $(mariadb_volume)
						sudo rm -rf $(wordpress_volume)

re:						fclean all
stop:					nginx_stop mariadb_stop wordpress_stop
clean:					nginx_clean mariadb_clean wordpress_clean
volumes:				nginx_volume mariadb_volume wordpress_volume

.SECONDEXPANSION:
