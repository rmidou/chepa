FROM debian:bullseye

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Création du répertoire pour cAdvisor
RUN mkdir -p /etc/cadvisor

# Téléchargement et installation de cAdvisor
RUN curl -L https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-arm64 -o /usr/local/bin/cadvisor \
    && chmod +x /usr/local/bin/cadvisor

# Exposition du port
EXPOSE 8080

# Démarrage de cAdvisor
CMD ["cadvisor", "--logtostderr", "--port=8080"] 