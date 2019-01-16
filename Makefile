#!/bin/bash

DOCKER_COMPOSE  = docker-compose

RUN_NODE        = $(DOCKER_COMPOSE) run --user $(shell id -u):$(shell id -g) --rm node

YARN            = $(RUN_NODE) yarn


.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help


##
##-----------------------------------------
##             P R O J E C T
##-----------------------------------------

start: ## Start the project
start:
	$(DOCKER_COMPOSE) up -d --remove-orphans --no-recreate

stop: ## Stop the project
	$(DOCKER_COMPOSE) stop

build: docker-compose.yml
	$(DOCKER_COMPOSE) build --pull

install: ## Install and start the project
install: docker-version pre .env build start

clean: ## Stop the project and remove generated files
clean: kill
	git clean -dfX

kill:
	$(DOCKER_COMPOSE) kill
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

docker-version: docker-compose.yml
	docker -v
	@DOCKER_MAJOR=$(shell docker -v | sed -e 's/.*version //' -e 's/,.*//' | cut -d\. -f1) ; \
	if [ $$DOCKER_MAJOR -lt 18 ] ; then \
		printf "\033[31;7mDocker version > 18.06.0+ is required.\nPlease install it and retry\nhttps://docs.docker.com/install/\n\n\033[0m"; \
		exit 1;\
	fi

docker-compose.yml: docker-compose.yml.dist
	@if [ -f docker-compose.yml ]; \
	then\
		echo 'docker-compose.yml already exists';\
	else\
		echo cp docker-compose.yml.dist docker-compose.yml;\
		cp docker-compose.yml.dist docker-compose.yml;\
	fi
##
##-----------------------------------------
##               U T I L S
##-----------------------------------------

pre: ssh .env

ssh:
	@if [ -f ~/.ssh/id_rsa ]; \
	then\
		echo 'ssh key already exists'; \
	else\
		ssh-keygen -t rsa -q -N ""; \
		printf "\033[33;7mPlease, copy this ssh key and paste it into your GitHub credentials.\n\033[0m"; \
		cat ~/.ssh/id_rsa.pub; \
		printf "\033[33;5;7mPress any key to continue...\033[0m"; \
		read continue; \
	fi

.env: .env.dist
	@if [ -f .env ]; \
	then\
		echo '.env already exists';\
	else\
		echo cp .env.dist .env;\
		cp .env.dist .env;\
	fi
psql: ## Run SQL console (psql) inside the container
	$(DOCKER_COMPOSE) exec db psql -U yadam

