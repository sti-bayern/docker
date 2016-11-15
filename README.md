# akilli/php

`akilli/base` based PHP 7 image.

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        php:
            image: akilli/php
            ports:
                - "9000:9000"

**NOTE**
Uses the `app` user that is created in the `akilli/base` image.
