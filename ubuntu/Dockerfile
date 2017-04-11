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
ENV PG=$PG \
    PGBIN=/usr/lib/postgresql/$PG/bin \
    PGCONF=/etc/postgresql/$PG/main \
    PGDATA=/data \
    PGPASS=$PGPASS \
    PATH=$PGBIN:$PATH

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
    mkdir -p /run/postgresql/pg_stat_tmp && \
    chown app:app \
        $PGCONF \
        /var/log/postgresql \
        /run/postgresql/pg_stat_tmp && \
    adduser app ssl-cert

COPY conf/ $PGCONF/

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
