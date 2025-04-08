#!/bin/bash

service mysql start

# Création de la base de données
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# Création de l'utilisateur
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Attribution des privilèges
mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';"

# Rafraîchissement des privilèges
mysql -e "FLUSH PRIVILEGES;"

# Configuration du root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Arrêt propre
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec mysqld_safe