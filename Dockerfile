FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Environment variables
#
ENV HTPWD=app \
    HTUSR=app

#
# Setup
#
RUN apk add --no-cache \
        docker-registry && \
    rm -rf /var/lib/registry

COPY config.yml /etc/docker-registry/config.yml

#
# Ports
#
EXPOSE 5000

#
# Command
#
COPY app-init.sh /usr/local/bin/app-init

CMD ["su-exec", "app", "docker-registry", "serve", "/etc/docker-registry/config.yml"]
