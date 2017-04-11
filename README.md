# akilli/postgres

`akilli/base` based PostgreSQL image

## Usage

In your `docker-compose.yml` include something like

    version: '3'
    volumes:
        postgres: {}
    services:
        postgres:
            image: akilli/postgres
            ports:
                - "5432:5432"
            volumes:
                - postgres:/data

**NOTE**
Uses the `app` user that is created in the `akilli/base` image.
