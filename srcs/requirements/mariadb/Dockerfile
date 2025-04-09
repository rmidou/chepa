FROM debian:bullseye

# Installation de MariaDB et configuration initiale
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    vim \
    procps \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql \
    && chmod -R 755 /var/lib/mysql

# Copie des fichiers de configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init_db.sh /usr/local/bin/

# Configuration pour permettre les connexions externes
RUN sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf \
    && chmod +x /usr/local/bin/init_db.sh

# Port MariaDB
EXPOSE 3306

# Démarrage du service
CMD ["sh", "-c", "/usr/local/bin/init_db.sh"]