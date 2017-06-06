FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Build variables
#
ARG HTPWD=app
ARG HTUSR=app

#
# Setup
#
RUN apk add --no-cache \
        apache2-utils \
        docker-registry && \
    htpasswd -Bbn $HTUSR $HTPWD > /etc/docker-registry/htpasswd && \
    apk del \
        apache2-utils && \
    rm -rf /var/lib/registry

COPY config.yml /etc/docker-registry/config.yml

#
# Ports
#
EXPOSE 5000

#
# Command
#
CMD ["su-exec", "app", "docker-registry", "serve", "/etc/docker-registry/config.yml"]
