# use the rest as arguments for targets
TARGET_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# ...and turn them into do-nothing targets
$(eval $(TARGET_ARGS):;@:)

COMPOSE=docker compose

help:		   		## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# containers

start: 				## start all containers
	$(COMPOSE) -f docker-compose.yml up -d

start-foreground:
	$(COMPOSE) -f docker-compose.yml up

stop: 				## stop all containers
	$(COMPOSE) -f docker-compose.yml stop

ls: 				## list all containers
	$(COMPOSE) -f docker-compose.yml ps

rebuild: 			## force rebuild a specific container
	$(COMPOSE) -f docker-compose.yml build --force-rm $(TARGET_ARGS)

logs: 				## tail container logs (example: make logs extractor)
	$(COMPOSE) -f docker-compose.yml logs -f $(TARGET_ARGS)

exec: 				## Open a bash of a specific container (usage: make exec [container] [command_to_execute]) example: make exec sender sh ls -la
	$(COMPOSE) -f docker-compose.yml exec $(TARGET_ARGS)

bash: 				## Open a bash of a specific container (usage: make bash [container])
	$(COMPOSE) -f docker-compose.yml exec $(TARGET_ARGS) bash

clean: 				## Purge container, removes the container, image and volumes attached to it, use with caution (usage: make clean [container])
	$(COMPOSE) -f docker-compose.yml stop; $(COMPOSE) -f docker-compose.yml rm -svf

restart: 			## Restart a specific container (usage: make restart [container])
	$(COMPOSE) -f docker-compose.yml stop $(TARGET_ARGS) && $(COMPOSE) -f docker-compose.yml start $(TARGET_ARGS)

clean-restart: 			## Stop, Rebuild and start a specific container(usage: make clean-restart [container])
	$(COMPOSE) -f docker-compose.yml stop $(TARGET_ARGS) && $(COMPOSE) -f docker-compose.yml rm -f $(TARGET_ARGS) && $(COMPOSE) -f docker-compose.yml build --force-rm $(TARGET_ARGS) && $(COMPOSE) -f docker-compose.yml up -d


# local

pep8:
	autopep8 --in-place --recursive .

flake8:
	pipenv run flake8

# app
freeze:
	pipenv run pipenv_to_requirements -f


install:
	pip install -r requirements-dev.txt

run:
	@cd src; pipenv run uvicorn --host 0.0.0.0 --port 8000 meerkat.configurations.app.main:app  --reload && echo "success!" || { echo "Crashed!"; exit 0; }

test:
	pipenv run pytest --cov --cov-report html

