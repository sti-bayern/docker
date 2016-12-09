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
        /etc/nginx/sites-enabled/* \
        /etc/nginx/sites-available/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY snippets/ /etc/nginx/snippets/

#
# Volumes
#
VOLUME ["/app"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
