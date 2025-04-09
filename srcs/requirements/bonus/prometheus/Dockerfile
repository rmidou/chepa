FROM debian:bullseye

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Création du répertoire pour Prometheus
RUN mkdir -p /etc/prometheus /var/lib/prometheus

# Téléchargement et installation de Prometheus pour l'architecture arm64
RUN curl -L https://github.com/prometheus/prometheus/releases/download/v2.50.1/prometheus-2.50.1.linux-arm64.tar.gz | \
    tar xz --strip-components=1 -C /usr/local/bin prometheus-2.50.1.linux-arm64/prometheus

# Copier la configuration
COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

# Définir les permissions
RUN chown -R nobody:nogroup /etc/prometheus /var/lib/prometheus

EXPOSE 9090

USER nobody
CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml", "--storage.tsdb.path=/var/lib/prometheus"]