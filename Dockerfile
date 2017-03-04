FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Setup
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /etc/nginx/sites-enabled \
        /etc/nginx/sites-available && \
    mkdir /etc/nginx/ssl && \
    cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/nginx/ssl/chain.pem && \
    cp /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/nginx/ssl/fullchain.pem && \
    cp /etc/ssl/private/ssl-cert-snakeoil.key /etc/nginx/ssl/privkey.pem && \
    openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

COPY nginx.conf /etc/nginx/nginx.conf
COPY snippets/ /etc/nginx/snippets/

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
