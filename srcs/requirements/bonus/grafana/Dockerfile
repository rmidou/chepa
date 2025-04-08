FROM grafana/grafana:10.2.3

USER root

# Installation de curl
RUN apk update && apk add --no-cache curl

# Retour à l'utilisateur grafana
USER grafana

# Copier la configuration personnalisée
COPY conf/grafana.ini /etc/grafana/grafana.ini

# Exposition du port 3001
ENV GF_SERVER_HTTP_PORT=3001

# Définir les variables d'environnement par défaut
ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=admin
ENV GF_USERS_ALLOW_SIGN_UP=false