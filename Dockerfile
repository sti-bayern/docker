FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG PG=9.6
ARG PGPASS=app

#
# Environment variables
#
ENV PGDATA=/data \
    PGPASS=$PGPASS
#
# Setup
#
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        ca-certificates \
        curl && \
    curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgres.list && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        postgresql-$PG \
        postgresql-contrib-$PG && \
    apt-get -y --purge remove \
        ca-certificates \
        curl && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/lib/postgresql && \
    ln -s ../share/postgresql-common/pg_wrapper /usr/bin/initdb && \
    ln -s ../share/postgresql-common/pg_wrapper /usr/bin/postgres

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
