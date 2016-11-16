FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG PG=9.6
ARG PG_APP=app
ARG PG_ROOT=postgres

#
# Environment variables
#
ENV PATH=/usr/lib/postgresql/$PG/bin:$PATH \
    PG=$PG \
    PG_APP=$PG_APP \
    PG_ROOT=$PG_ROOT

#
# APT packages
#
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgres.list

RUN apt-get update && apt-get install -y \
    postgresql-$PG \
    postgresql-contrib-$PG

RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/postgresql && \
    mkdir -p /var/lib/postgresql && \
    mkdir -p /var/run/postgresql/$PG-main.pg_stat_tmp && \
    chown postgres:postgres /var/run/postgresql/$PG-main.pg_stat_tmp

#
# Configuration
#
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PG/main/postgresql.conf

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
