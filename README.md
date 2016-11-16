# akilli/postgres

`akilli/base` based PostgreSQL image

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        postgres:
            image: akilli/postgres
            ports:
                - "5432:5432"

or with a separate data volume

    version: '2'
    volumes:
        postgresdata: {}
    services:
        postgres:
            image: akilli/postgres
            ports:
                - "5432:5432"
            volumes:
                - postgresdata:/var/lib/postgresql

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. Creates a corresponing role and a database named `app`.
Please see Dockerfile for supported build args to adjust Postgres version and passwords for both roles `postgres` and 
`app`.
