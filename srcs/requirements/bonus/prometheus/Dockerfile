FROM prom/prometheus:latest

# Copier la configuration
COPY conf/prometheus.yml /etc/prometheus/prometheus.yml

EXPOSE 9090

CMD ["--config.file=/etc/prometheus/prometheus.yml"]