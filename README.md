# Supported tags and respective `Dockerfile` links

- [`5.6`, `latest` (*5.6/Dockerfile*)](https://github.com/akilli/docker/blob/master/php/Dockerfile)
- [`7.0` (*7.0/Dockerfile*)](https://github.com/akilli/docker/blob/master/php-7.0/Dockerfile)

# php

`debian:jessie` based PHP image.

**Note:** `7.0` currently builds from PHP `master`.

## Usage

Run from docker command line, p.e.

    $ docker run -d -p 9000:9000 -p 9001:9001 akilli/php

or use docker-compose, p.e. with `docker-compose.yml` including something like

    php:
        image: akilli/php
        ports:
            - "9000:9000"
            - "9001:9001"

or

    app:
        image: debian:jessie
        volumes:
            - .:/var/www/html
    php:
        image: akilli/php
        ports:
            - "9000:9000"
            - "9001:9001"
        volumes_from:
            - app
    nginx:
        image: akilli/nginx
        ports:
            - "80:80"
            - "443:443"
        volumes_from:
            - app
        links:
            - php:php
