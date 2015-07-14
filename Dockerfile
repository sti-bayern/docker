FROM debian:jessie

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-contrib-9.4

RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/postgresql && \
    mkdir -p /var/lib/postgresql && \
    mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp && \
    chown postgres:postgres /var/run/postgresql/9.4-main.pg_stat_tmp

#
# Configuration
#
RUN echo "host all all 0.0.0.0/0  trust" >> /etc/postgresql/9.4/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf

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
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "--config-file=/etc/postgresql/9.4/main/postgresql.conf"]
