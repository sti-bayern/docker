FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Environment variables
#
ENV MPASS=app

#
# Setup
#
RUN apk add --no-cache \
        mysql \
        mysql-client && \
    rm -rf /var/lib/mysql && \
    mkdir -p \
        /init/mysql \
        /run/mysqld \
        /var/log/app

COPY rootfs/ /

#
# Ports
#
EXPOSE 3306
