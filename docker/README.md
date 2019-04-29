# `akilli/docker`

`akilli/base` based docker image that includes `sudo`, `curl`, `docker` and `docker-compose` for direct usage or as extension point. 

Uses the `app` user that is created in the `akilli/base` image. `sudo` is configured to allow the `app` user the execution of `docker`and `docker-compose` commands. 

## Usage

In your `docker-compose.yml` include something like

    services:
      docker:
        image: akilli/docker
        volumes:
          - source: /var/run/docker.sock
            target: /var/run/docker.sock
            type: bind
            read_only: true
