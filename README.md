# Supported tags and respective `Dockerfile` links

- [`5.6` (*5.6/Dockerfile*)](https://github.com/akilli/docker/blob/master/php5/Dockerfile)
- [`7.0`, `latest` (*7.0/Dockerfile*)](https://github.com/akilli/docker/blob/master/php/Dockerfile)
- [`src` (*src/Dockerfile*)](https://github.com/akilli/docker/blob/master/php-src/Dockerfile)

# php

`akilli:base` based PHP image.

## Usage

Run from docker command line, p.e.

    $ docker run -d -p 4000:4000 -p 8000:8000 -p 9000:9000 akilli/php

or use docker-compose, p.e. with `docker-compose.yml` including something like

    php:
        image: akilli/php
        ports:
            - "4000:4000"
            - "8000:8000"
            - "9000:9000"

or

    app:
        image: debian:jessie
        volumes:
            - .:/var/www/html
    php:
        image: akilli/php
        ports:
            - "4000:4000"
            - "8000:8000"
            - "9000:9000"
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
