# `akilli/php`

`akilli/base` based PHP image.

Uses the `app` user that is created in the `akilli/base` image. It is configured with `opcache.revalidate_freq = 0`, 
which is not suitable for development (see the `snippets/vhost.conf` in `akilli/nginx` for one of several possibilities
to adjust this setting for development).

## Usage

In your `docker-compose.yml` include something like

    version: "3.2"
    services:
      php:
        image: akilli/php
        ports:
          - "9000:9000"
