DATABASE_URL:=postgres://postgres:foobarbaz@localhost:5432/postgres
DEV_COMPOSE_FILE=docker-compose-dev.yml
DEBUG_COMPOSE_FILE=docker-compose-debug.yml
TEST_COMPOSE_FILE=docker-compose-test.yml
PROD_COMPOSE_FILE=docker-compose-prod.yml

## RUN THE WEB APP AND THE SERVICES LOCALLY ON THE HOST, NO CONTAINERS

.PHONY: run-postgres
run-postgres:
	@echo Starting postgres container
	-docker run \
		-e POSTGRES_PASSWORD=foobarbaz \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		postgres:17.0-alpine

.PHONY: run-api-node
run-api-node:
	@echo Starting node api
	cd api-node && \
		DATABASE_URL=${DATABASE_URL} \
		npm run dev

.PHONY: run-api-golang
run-api-golang:
	@echo Starting golang api
	cd api-golang && \
		DATABASE_URL=${DATABASE_URL} \
		go run main.go

.PHONY: run-client-react
run-client-react:
	@echo Starting react client
	cd client-react && \
		npm run dev



### DOCKER COMPOSE COMMANDS DEV STAGE


.PHONY: compose-build-dev
compose-build:
	docker compose -f $(DEV_COMPOSE_FILE) build


.PHONY: compose-up-dev
compose-up:
	docker compose -f $(DEV_COMPOSE_FILE) up


.PHONY: compose-up-build-dev
compose-up-build:
	docker compose -f $(DEV_COMPOSE_FILE) up --build


.PHONY: compose-up-debug-build-dev
compose-up-debug-build:
	docker compose -f $(DEV_COMPOSE_FILE) -f $(DEBUG_COMPOSE_FILE) up --build


.PHONY: compose-down-dev
compose-down:
	docker compose -f $(DEV_COMPOSE_FILE) down


### DOCKER COMPOSE COMMANDS PROD STAGE


.PHONY: compose-build-prod
compose-build:
	docker compose -f $(PROD_COMPOSE_FILE) build


.PHONY: compose-up-prod
compose-up:
	docker compose -f $(PROD_COMPOSE_FILE) up


.PHONY: compose-up-build-prod
compose-up-build:
	docker compose -f $(PROD_COMPOSE_FILE) up --build


.PHONY: compose-up-debug-build-prod
compose-up-debug-build:
	docker compose -f $(PROD_COMPOSE_FILE) -f $(DEBUG_COMPOSE_FILE) up --build


.PHONY: compose-down-prod
compose-down:
	docker compose -f $(PROD_COMPOSE_FILE) down


### TESTING STAGE

DOCKERCONTEXT_DIR:=./
DOCKERFILE_DIR:=./

.PHONY: run-tests
run-tests:
	docker compose -f $(DEV_COMPOSE_FILE) -f $(TEST_COMPOSE_FILE) run --build api-golang
	docker compose -f $(DEV_COMPOSE_FILE) -f $(TEST_COMPOSE_FILE) run --build api-node
