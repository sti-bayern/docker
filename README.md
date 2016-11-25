# nginx

`akilli/base` based nginx image

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        php:
            image: akilli/php
            ports:
                - "9000:9000"
            volumes:
                - .:/home/app/root
        nginx:
            image: akilli/nginx
            ports:
                - "80:80"
                - "443:443"
            volumes:
                - .:/home/app/root

Then browse to `http://localhost` or `https://localhost`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. The included default site 
configuration file sets the document root to `/home/app/root/public` and a PHP handler at `php:9000`, so you have to 
overwrite it if this does not work for you... check out the `00` folder for an example. 
