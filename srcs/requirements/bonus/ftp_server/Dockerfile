FROM debian:buster

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Création des répertoires nécessaires
RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /var/ftp && \
    useradd -m ftpuser && \
    echo "ftpuser:password" | chpasswd && \
    chown ftpuser:ftpuser /var/ftp

# Configuration de vsftpd
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Définir les permissions correctes
RUN chmod 555 /var/run/vsftpd/empty && \
    chmod 755 /var/ftp

EXPOSE 20 21 21100-21110

CMD ["vsftpd", "/etc/vsftpd.conf"]