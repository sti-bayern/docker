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
                - ./vhost.conf:/etc/nginx/sites-enabled/vhost.conf

Then browse to `http://localhost` or `https://localhost`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image. 
