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
    mkdir /run/postgresql && \
    chown -R app:app /run/postgresql

#
# Ports
#
EXPOSE 5432

#
# Command
#
COPY app-init.sh /usr/local/bin/app-init

CMD ["su-exec", "app", "postgres"]
