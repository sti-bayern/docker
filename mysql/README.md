# `akilli/mysql`

`akilli/base` based MariaDB image.

Uses the `app` user that is created in the `akilli/base` image. Creates the directory `/init/mysql` and executes all `*.sql` files in this directory on database initialisation.

## Usage

In your `docker-compose.yml` include something like

    volumes:
      mysql: {}
    services:
      mysql:
        image: akilli/mysql
        ports:
          - "3306:3306"
        volumes:
          - source: mysql
            target: /data
            type: volume
