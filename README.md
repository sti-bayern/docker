# PHP

debian:jessie based PHP 5.6 image

## Usage

Run from docker command line, p.e.

    $ docker run -d -p 9000:9000 -p 9001:9001 akilli/php

or use docker-compose, p.e. with _docker-compose.yml_ including something like

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
