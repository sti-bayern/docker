FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG POSTGRES=9.6
ARG POSTGRES_APP_PWD=app
ARG POSTGRES_PWD=postgres

#
# Environment variables
#
ENV PATH=/usr/lib/postgresql/$POSTGRES/bin:$PATH \
    POSTGRES=$POSTGRES \
    POSTGRES_APP_PWD=$POSTGRES_APP_PWD \
    POSTGRES_PWD=$POSTGRES_PWD

#
# APT packages
#
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgres.list

RUN apt-get update && apt-get install -y \
    postgresql-$POSTGRES \
    postgresql-contrib-$POSTGRES

RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/postgresql && \
    mkdir -p /var/lib/postgresql && \
    mkdir -p /var/run/postgresql/$POSTGRES-main.pg_stat_tmp && \
    chown postgres:postgres /var/run/postgresql/$POSTGRES-main.pg_stat_tmp

#
# Configuration
#
RUN echo "listen_addresses='*'" >> /etc/postgresql/$POSTGRES/main/postgresql.conf

COPY pg_hba.conf /etc/postgresql/$POSTGRES/main/pg_hba.conf

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
