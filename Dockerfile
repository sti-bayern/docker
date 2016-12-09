FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG PG=9.6
ARG PG_ROOT=postgres

#
# Environment variables
#
ENV PATH=/usr/lib/postgresql/$PG/bin:$PATH \
    PG=$PG \
    PG_ROOT=$PG_ROOT

#
# Setup
#
RUN wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgres.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-$PG \
        postgresql-contrib-$PG && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/lib/postgresql && \
    mkdir -p \
        /var/lib/postgresql \
        /var/run/postgresql/$PG-main.pg_stat_tmp && \
    chown postgres:postgres /var/run/postgresql/$PG-main.pg_stat_tmp && \
    echo "listen_addresses='*'" >> /etc/postgresql/$PG/main/postgresql.conf

COPY pg_hba.conf /etc/postgresql/$PG/main/pg_hba.conf

#
# Volumes
#
VOLUME ["/var/lib/postgresql"]

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
