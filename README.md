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

or with a separate data container

    version: '2'
    services:
        postgresdata:
            image: akilli/base
            volumes:
                - /var/lib/postgresql
        postgres:
            image: akilli/postgres
            ports:
                - "5432:5432"
            volumes_from:
                - postgresdata
