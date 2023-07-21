CONTAINERS	:= $(shell docker ps -aq)
VOLUMES		:= $(shell docker volume ls -q)
IMAGES		:= $(shell docker image ls -aq)

up:
	docker compose up -d

build:
	docker compose up -d --build

down:
	docker compose down

clean: down
	if [ -n "$(CONTAINERS)" ]; then docker rm -f $(CONTAINERS); fi
	if [ -n "$(VOLUMES)" ]; then docker volume rm -f $(VOLUMES); fi
	if [ -n "$(IMAGES)" ]; then docker image rm -f $(IMAGES); fi
	sudo rm -rf logs volume_files volume_data
	docker system prune -a --volumes -f

re: clean
	$(MAKE) build

logs:
	docker compose logs

.PHONY: up build down clean re logs