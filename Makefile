mariadb_volume		=	/home/trobin/data/mariadb
wordpress_volume	=	/home/trobin/data/wordpress
docker_compose_dir	=	/home/trobin/inception/srcs

#nginx_volume:		;
nginx_volume:		;	mkdir -p $(wordpress_volume)
mariadb_volume:		;	mkdir -p $(mariadb_volume)
wordpress_volume:	;	mkdir -p $(wordpress_volume)

%_up:					%_volume
						cd $(docker_compose_dir) \
						&& docker compose up $* --build --detach

%_inspect:			;	cd $(docker_compose_dir) \
						&& docker compose exec $* /bin/bash # --user trobin

%_stop:				;	cd $(docker_compose_dir) \
						&& docker compose stop $*

%_log:				;	cd $(docker_compose_dir) \
						&& docker compose logs $*

%_clean:				%_stop
						cd $(docker_compose_dir) \
						&& docker system prune \
						&& docker compose rm $* \
						&& sudo rm -rf $(mariadb_volume)/*

stop:					nginx_stop mariadb_stop wordpress_stop
clean:					nginx_clean mariadb_clean wordpress_clean
volumes:				nginx_volume mariadb_volume wordpress_volume

.SECONDEXPANSION:
