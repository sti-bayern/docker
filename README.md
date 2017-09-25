# `akilli/maildev`

`akilli/node` based maildev image.

## Usage

In your `docker-compose.yml` include something like

    version: "3.3"
    services:
      maildev:
        image: akilli/maildev
        ports:
          - "1025:1025"
          - "1080:1080"
