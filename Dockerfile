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
    openssl \
        req -x509 \
        -nodes \
        -sha256 \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/loc.key \
        -out /etc/nginx/ssl/loc.crt \
        -subj "/C=DE/ST=/L=LOCation/O=LOC/CN=*.loc" && \
    openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

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
