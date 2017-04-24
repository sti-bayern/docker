FROM akilli/base:alpine

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG PGPASS=app

#
# Environment variables
#
ENV PGDATA=/data \
    PGPASS=$PGPASS

#
# Setup
#
RUN apk add --no-cache \
        postgresql \
        postgresql-contrib && \
    mkdir /run/postgresql

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
