FROM akilli/base

LABEL maintainer "Ayhan Akilli"

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
    mkdir /run/postgresql && \
    chown -R app:app \
        /run/postgresql \
        /var/log/postgresql

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY app-init.sh /usr/local/bin/app-init

CMD ["su-exec", "app", "postgres"]
