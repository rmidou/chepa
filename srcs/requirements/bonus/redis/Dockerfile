FROM debian:buster

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

# Configuration Redis
COPY conf/redis.conf /etc/redis/redis.conf

# Permissions
RUN chown redis:redis /etc/redis/redis.conf

# Port Redis
EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]