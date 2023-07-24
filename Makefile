CONTAINERS	:= $(shell docker ps -aq)
VOLUMES		:= $(shell docker volume ls -q)
IMAGES		:= $(shell docker image ls -aq)

up:
	cd srcs && docker compose up -d

build:
	cd srcs && docker compose up -d --build

down:
	cd srcs && docker compose down

clean: down
	if [ -n "$(CONTAINERS)" ]; then docker rm -f $(CONTAINERS); fi
	if [ -n "$(VOLUMES)" ]; then docker volume rm -f $(VOLUMES); fi
	if [ -n "$(IMAGES)" ]; then docker image rm -f $(IMAGES); fi
	docker system prune -a --volumes -f
	sudo rm -rf srcs/volume_files srcs/volume_data
	sudo rm -rf ~/.docker/config.json 
	sudo systemctl restart docker

re: clean
	$(MAKE) build

logs:
	cd srcs && docker compose logs -f

.PHONY: up build down clean re logs