# akilli/nginx

`akilli/base` based nginx image

## Usage

In your `docker-compose.yml` include something like

    version: '3'
    services:
        nginx:
            image: akilli/nginx
            ports:
                - "80:80"
                - "443:443"
            volumes:
                - .:/app

Then browse to `http://localhost` or `https://localhost`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. Comes without any `server` blocks, `/etc/nginx/nginx.conf` 
includes `/app/nginx.conf` instead, so you have to provide this file. Come with some useful snippets for `ssl`, `http2`
and `php-fpm` configuration.
