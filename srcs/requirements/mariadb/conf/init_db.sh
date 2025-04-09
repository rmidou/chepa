#!/bin/bash

echo "[INFO] Starting MariaDB initialization..."

# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Attendre que le service MySQL soit prêt
echo "[INFO] Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h localhost --silent; do
    echo "[INFO] MariaDB is not ready yet. Waiting..."
    sleep 2
done

echo "[INFO] MariaDB is ready. Configuring..."

# Configuration du root
echo "[INFO] Setting root password..."
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Création de la base de données
echo "[INFO] Creating database ${SQL_DATABASE}..."
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# Création de l'utilisateur
echo "[INFO] Creating user ${SQL_USER}..."
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Attribution des privilèges
echo "[INFO] Granting privileges..."
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"

# Rafraîchissement des privilèges
echo "[INFO] Flushing privileges..."
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

echo "[INFO] MariaDB initialization completed successfully!"

# Arrêt propre et redémarrage
echo "[INFO] Restarting MariaDB..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Démarrer MariaDB en mode foreground
exec mysqld_safe