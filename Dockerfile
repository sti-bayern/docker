FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Set environment variables
#
ENV PG=9.5

#
# APT packages
#
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
RUN echo "host all all 0.0.0.0/0  trust" >> /etc/postgresql/$PG/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/$PG/main/postgresql.conf

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
