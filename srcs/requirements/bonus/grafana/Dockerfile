FROM debian:bullseye

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Ajout du dépôt Grafana
RUN curl -fsSL https://packages.grafana.com/gpg.key | gpg --dearmor -o /usr/share/keyrings/grafana-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/grafana-archive-keyring.gpg] https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

# Installation de Grafana
RUN apt-get update && apt-get install -y grafana \
    && rm -rf /var/lib/apt/lists/*

# Création des répertoires nécessaires
RUN mkdir -p /var/lib/grafana \
    && mkdir -p /var/log/grafana \
    && mkdir -p /usr/share/grafana/data \
    && chown -R grafana:grafana /var/lib/grafana \
    && chown -R grafana:grafana /var/log/grafana \
    && chown -R grafana:grafana /usr/share/grafana/data \
    && chmod 755 /var/lib/grafana \
    && chmod 755 /var/log/grafana \
    && chmod 755 /usr/share/grafana/data

# Copier la configuration personnalisée
COPY conf/grafana.ini /etc/grafana/grafana.ini

# Exposition du port 3001
ENV GF_SERVER_HTTP_PORT=3001

# Définir les variables d'environnement par défaut
ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=admin
ENV GF_USERS_ALLOW_SIGN_UP=false

EXPOSE 3001

USER grafana
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]