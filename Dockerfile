FROM akilli:base

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    PG_MAJOR=9.5

#
# APT packages
#
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgsql.list

RUN apt-get update && apt-get install -y \
    postgresql-$PG_MAJOR \
    postgresql-contrib-$PG_MAJOR

RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/postgresql && \
    mkdir -p /var/lib/postgresql && \
    mkdir -p /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp && \
    chown postgres:postgres /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp

#
# Configuration
#
RUN echo "host all all 0.0.0.0/0  trust" >> /etc/postgresql/$PG_MAJOR/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/$PG_MAJOR/main/postgresql.conf

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
CMD /usr/lib/postgresql/$PG_MAJOR/bin/postgres --config-file=/etc/postgresql/$PG_MAJOR/main/postgresql.conf
