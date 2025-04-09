FROM debian:bullseye

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Création du répertoire pour Node Exporter
RUN mkdir -p /etc/node_exporter

# Téléchargement et installation de Node Exporter
RUN curl -L https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-arm64.tar.gz | \
    tar xz --strip-components=1 -C /usr/local/bin node_exporter-1.7.0.linux-arm64/node_exporter

# Définir les permissions
RUN chown -R nobody:nogroup /etc/node_exporter

EXPOSE 9100

USER nobody
CMD ["node_exporter"] 