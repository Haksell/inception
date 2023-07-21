CONTAINERS	:= $(shell docker ps -a -q)
VOLUMES		:= $(shell docker volume ls -q)
IMAGES		:= $(shell docker image ls -q)

all:
	docker compose up -d

clean:
	docker compose down

fclean: clean
	if [ -n "$(CONTAINERS)" ]; then docker rm -f $(CONTAINERS); fi
	if [ -n "$(VOLUMES)" ]; then docker volume rm $(VOLUMES); fi
	if [ -n "$(IMAGES)" ]; then docker image rm $(IMAGES); fi
	docker system prune -a --volumes -f

re: fclean
	docker compose up -d --build

logging:
	docker compose logs -f

.SILENT: all clean fclean rebuild logs