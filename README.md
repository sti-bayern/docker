# akilli/gogs

`akilli/base` based Gogs image

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    services:
        gogs:
            image: akilli/gogs
            ports:
                - "3000:3000"

or with a separate data volume

    version: '2'
    volumes:
        gogsdata: {}
    services:
        gogs:
            image: akilli/gogs
            ports:
                - "3000:3000"
            volumes:
                - gogsdata:/opt/gogs/data

Then browse to `http://localhost:3000`

**NOTE**
Uses the `app` user that is created in the `akilli/base` image.

