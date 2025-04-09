FROM debian:bullseye

# Installation de Python et des dépendances
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Création du répertoire pour le site statique
RUN mkdir -p /var/www/static

# Copie des fichiers
COPY conf/index.html /var/www/static/
COPY src/app.py /app/

# Exposer le port
EXPOSE 3000

# Démarrer le serveur
CMD ["python3", "/app/app.py"]