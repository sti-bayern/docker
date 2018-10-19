FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Environment variables
#
ENV PGDATA=/data \
    PGPASS=app

#
# Setup
#
RUN apk add --no-cache \
        postgresql \
        postgresql-contrib && \
    rm -rf \
        /var/lib/postgresql \
        /var/log/postgresql && \
    mkdir -p \
        /init/postgres \
        /run/postgresql && \
    chown -R app:app /run/postgresql

COPY s6/ /etc/s6/

#
# Ports
#
EXPOSE 5432
