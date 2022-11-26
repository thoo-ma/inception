FROM debian:buster

# cf. https://www.linode.com/docs/guides/how-to-install-wordpress-using-wp-cli-on-debian-10/
# cf. https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/

#RUN apt-get install -y php php-mysql php-fpm wp-cli
RUN apt-get update
RUN apt-get install -y php # version 7.3
RUN apt-get install -y wordpress
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN apt-get install -y less # needed by wp-cli (https://github.com/wp-cli/wp-cli/issues/5333)

WORKDIR /tmp

# Download wp-cli
RUN wget -O php-wpcli_0.14.0_all.deb \
    https://github.com/wp-cli/builds/blob/gh-pages/deb/php-wpcli_0.14.0_all.deb?raw=true \
    && dpkg -i php-wpcli_0.14.0_all.deb

# Download wp-cli tab completion (optional)
RUN wget -O wp-completion.bash \
    https://raw.githubusercontent.com/wp-cli/wp-cli/v2.7.1/utils/wp-completion.bash \
    && echo "source /tmp/wp-completion.bash" >> ~/.bashrc \
    && echo "alias wp='wp --allow-root'" >> ~/.bashrc # tmp

# Create the wordpress database (assume mariadb container is running)
# (SHOULD persist even if the corresponding docker volume is deleted!)
#RUN mkdir -p /home/trobin/data/mariadb
#RUN chown -R mysql:mysql /home/trobin/data/mariadb

SHELL ["/bin/bash", "source", "~/.bashrc" ]
