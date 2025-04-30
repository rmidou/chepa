#!/bin/bash

# Attendre que le service MariaDB soit prêt
max_tries=30  # Augmenter le nombre de tentatives
count=0
while [ $count -lt $max_tries ]; do
    if mysql -h mariadb -u wp_user -ppassword wordpress -e "SELECT 1" &>/dev/null; then
        break
    fi
    echo "[INFO] MariaDB is not ready yet. Waiting... ($((count + 1))/$max_tries)"
    count=$((count + 1))
    sleep 2
done

if [ $count -eq $max_tries ]; then
    echo "[ERROR] MariaDB connection timeout"
    exit 1
fi

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

    # Attendre encore un peu pour s'assurer que la base est prête
    sleep 5

    echo "[INFO] Installing WordPress core..."
    wp core install \
        --allow-root \
        --url=$DOMAIN_NAME \
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

    echo "[INFO] Installing and enabling Redis Object Cache plugin..."
    wp plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'
    wp redis enable --allow-root --path='/var/www/wordpress'
    # Ajout de la configuration Redis dans wp-config.php si elle n'existe pas déjà
    if ! grep -q "WP_REDIS_HOST" wp-config.php; then
        echo "define('WP_REDIS_HOST', 'redis');" >> wp-config.php
    fi
fi

echo "[INFO] Starting PHP-FPM..."
/usr/sbin/php-fpm7.4 -F