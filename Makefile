DATABASE_URL:=postgres://postgres:foobarbaz@localhost:5432/postgres

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


### DOCKER COMPOSE COMMANDS

.PHONY: compose-build
compose-build:
	docker compose build

.PHONY: compose-up
compose-up:
	docker compose up

.PHONY: compose-up-build
compose-up-build:
	docker compose up --build

.PHONY: compose-down
compose-down:
	docker compose down
