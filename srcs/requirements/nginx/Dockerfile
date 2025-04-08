FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx \
    vim \
    curl \
    openssl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/nginx/ssl \
    && mkdir -p /var/run/nginx \
    && mkdir -p /var/www/html \
    && chmod -R 755 /var/www/html \
    && chown -R www-data:www-data /var/www/html

# Copier la configuration nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copier la page d'accueil
COPY index.html /var/www/html/

# Génération du certificat SSL auto-signé
RUN openssl req -x509 -nodes \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -days 365 \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=nbiron.42.fr/UID=login"

# Définir les bonnes permissions
RUN chmod 600 /etc/nginx/ssl/inception.key \
    && chmod 644 /etc/nginx/ssl/inception.crt \
    && chmod 644 /var/www/html/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]