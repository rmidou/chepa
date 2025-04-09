NAME = inception

all: up

up:
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a

fclean: clean
	docker volume rm $$(docker volume ls -q)
	sudo rm -rf /home/data/wordpress/*
	sudo rm -rf /home/data/mariadb/*

re: fclean all

.PHONY: all up down clean fclean re 