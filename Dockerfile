FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Setup
#
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        nginx \
        openssl && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /etc/nginx/sites-enabled \
        /etc/nginx/sites-available && \
    mkdir /etc/nginx/ssl && \
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
