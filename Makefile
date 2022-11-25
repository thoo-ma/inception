mariadb_volume		=	/home/trobin/data/mariadb
wordpress_volume	=	/home/trobin/data/wordpress
docker_compose_dir	=	/home/trobin/inception/srcs

#nginx_volume:		;
nginx_volume:		;	mkdir -p $(wordpress_volume)
mariadb_volume:		;	mkdir -p $(mariadb_volume)
wordpress_volume:	;	mkdir -p $(wordpress_volume)
volumes:				nginx_volume mariadb_volume wordpress_volume

%_up:					$(subst _up,_volume,$@)
						cd $(docker_compose_dir) \
						&& docker compose up $(subst _up,,$@) --build --detach

%_inspect:				$(subst _inspect,_up,$@)
						cd $(docker_compose_dir) \
						&& docker compose exec $(subst _inspect,,$@) /bin/bash

%_stop:				;	cd $(docker_compose_dir) \
						&& docker compose stop $(subst _stop,,$@)

%_rm:					# $(subst _rm,_stop,$@)
						cd $(docker_compose_dir) \
						&& docker compose rm $(subst _rm,,$@)

stop:					nginx_stop mariadb_stop wordpress_stop
rm:						nginx_rm mariadb_rm wordpress_rm
