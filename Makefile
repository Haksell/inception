CONTAINERS	:= $(shell docker ps -a -q)
VOLUMES		:= $(shell docker volume ls -q)
IMAGES		:= $(shell docker image ls -q)

up:
	docker compose up -d

down:
	docker compose down

clean: down
	if [ -n "$(CONTAINERS)" ]; then docker rm -f $(CONTAINERS); fi
	if [ -n "$(VOLUMES)" ]; then docker volume rm $(VOLUMES); fi
	if [ -n "$(IMAGES)" ]; then docker image rm $(IMAGES); fi
	sudo rm -rf logs volume_files volume_data
	docker system prune -a --volumes -f

re: fclean
	docker compose up -d --build

logs:
	docker compose logs -f

.PHONY: up down clean re logs