FROM debian:bullseye

# Installation des paquets nécessaires
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php

# Installation de WordPress
WORKDIR /var/www
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz \
    && tar -xzf wordpress-6.0-fr_FR.tar.gz \
    && rm wordpress-6.0-fr_FR.tar.gz \
    && chown -R www-data:www-data /var/www/wordpress

# Installation de WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copie des fichiers de configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY conf/auto_config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/auto_config.sh"]