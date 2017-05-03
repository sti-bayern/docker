# `akilli/resgitry`

`akilli/base` based Docker Registry image with htpasswd authentication.

Uses the `app` user that is created in the `akilli/base` image.

## Usage

In your `docker-compose.yml` include something like

    version: "3.2"
    volumes:
      resgitry: {}
    services:
      resgitry:
        image: akilli/resgitry
        ports:
          - "5000:5000"
        volumes:
          - source: resgitry
            target: /data
            type: volume
