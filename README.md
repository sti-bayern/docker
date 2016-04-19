# nginx

`akilli:base` based nginx mainline image

## Usage

Run from docker command line, p.e.

    $ docker run -d -p 80:80 -p 443:443 akilli/nginx

or use docker-compose, p.e. with `docker-compose.yml` including something like

    nginx:
        image: akilli/nginx
        ports:
            - "80:80"
            - "443:443"
        volumes:
            - .:/var/www/html

or

    app:
        image: akilli:base
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

Then browse to

    http://localhost

or

    https://localhost
