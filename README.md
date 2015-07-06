# postgres

`debian:jessie` based PostgreSQL 9.4 image

## Usage

Run from docker command line, p.e.

    $ docker run -d -p 5432:5432 akilli/postgres

or use docker-compose, p.e. with `docker-compose.yml` including something like

    postgres:
        image: akilli/postgres
        ports:
            - "5432:5432"

or with data-only container

    postgresdata:
        image: debian:jessie
        volumes:
            - /var/lib/postgresql
    postgres:
        image: akilli/postgres
        ports:
            - "5432:5432"
        volumes_from:
            - postgresdata
