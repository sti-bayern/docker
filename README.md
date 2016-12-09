# akilli/gogs

`akilli/base` based Gogs image

## Usage

In your `docker-compose.yml` include something like

    version: '2'
    volumes:
        gogsdata: {}
    services:
        gogs:
            image: akilli/gogs
            ports:
                - "3000:3000"
            volumes:
                - gogsdata:/data

Then browse to `http://localhost:3000`
