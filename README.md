# Sample web application

![](./readme-assets/app-screenshot.png)

## Minimal 3 tier web application
- **React frontend:** Uses react query to load data from the two apis and display the result
- **Node JS and Golang APIs:** Both have `/` and `/ping` endpoints. `/` queries the Database for the current time, and `/ping` returns `pong`
- **Postgres Database:** An empty PostgreSQL database with no tables or data. Used to show how to set up connectivity. The API applications execute `SELECT NOW() as now;` to determine the current time to return.

![](./readme-assets/tech-stack.png)

## Running the Application

The `Makefile` contains the commands to start each application.

### Postgres

Postgres is run in a container.

`make run-postgres` will start postgres in a container and publish port 5432 from the container to your localhost.

### api-node

To run the node api you will need to run `npm install` to install the dependencies.

After installing the dependencies, `make run-api-node` will run the api in development mode with nodemon for restarting the app when you make source code changes.

### api-golang 

To run the golang api you will need to run `go mod download` to download and install the dependencies.

After installing the dependencies, `make run-api-golang` will build and run the api.

### client-react

Like `api-node`, you will first need to install the dependencies with `npm install`

After installing the dependencies, `make run-client-react` will use vite to run the react app in development mode.
