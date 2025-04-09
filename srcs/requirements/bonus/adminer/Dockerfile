FROM debian:bullseye

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-common \
    php7.4-curl \
    php7.4-json \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Créer le dossier nécessaire
RUN mkdir -p /var/www/html

# Télécharger Adminer
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php

# Créer le dossier pour PHP-FPM
RUN mkdir -p /run/php

# Définir les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html

# Exposer le port
EXPOSE 8080

# Commande de démarrage pour servir Adminer
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]