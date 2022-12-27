compose_file		=	srcs/docker-compose.yml
services			=	nginx mariadb wordpress
mariadb_volume		=	$(HOME)/data/mariadb
wordpress_volume	=	$(HOME)/data/wordpress/public_html

nginx_volume:		;
mariadb_volume:		;	mkdir -p $(mariadb_volume)
wordpress_volume:	;	mkdir -p $(wordpress_volume)

all:	volumes		;	docker compose --file $(compose_file) up --build --detach

%_up:	%_volume	;	docker compose --file $(compose_file) up $* --build --detach

%_it:				;	docker compose --file $(compose_file) exec $* /bin/bash

%_stop:				;	docker compose --file $(compose_file) stop $*

%_log:				;	docker compose --file $(compose_file) logs $*

%_clean:	%_stop	;	docker compose --file $(compose_file) rm $*

%_fclean:	%_clean	;	docker volume rm --force inception_$*

fclean:					clean
						docker system prune
						sudo rm -rf $(mariadb_volume)
						sudo rm -rf $(wordpress_volume)

stop:					$(foreach service, $(services), $(service)_stop)
clean:					$(foreach service, $(services), $(service)_clean)
fclean:					$(foreach service, $(services), $(service)_fclean)
volumes:				$(foreach service, $(services), $(service)_volume)

re:						fclean all

.SECONDEXPANSION:
