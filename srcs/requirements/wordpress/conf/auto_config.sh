#!/bin/bash

# Attendre que MariaDB soit prêt
sleep 10

cd /var/www/wordpress

# Créer le dossier pour PHP si nécessaire
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi

# Configuration de WordPress
if [ ! -f wp-config.php ]; then
    echo "[INFO] Creating WordPress configuration..."
    wp config create \
        --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress' \
        --skip-check \
        --force

    echo "[INFO] Installing WordPress core..."
    wp core install \
        --allow-root \
        --url=nbiron.42.fr \
        --title="Inception WordPress" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/wordpress' \
        --skip-email || true

    echo "[INFO] Creating second user..."
    wp user create \
        --allow-root \
        $WP_USER $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=author \
        --path='/var/www/wordpress' || true
fi

echo "[INFO] Starting PHP-FPM..."
/usr/sbin/php-fpm7.3 -F