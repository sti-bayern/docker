#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /run/postgresql

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    sudo -u postgres mkdir -p /var/lib/postgresql/$PG_MAJOR/main
    sudo -u postgres /usr/lib/postgresql/$PG_MAJOR/bin/initdb -D /var/lib/postgresql/$PG_MAJOR/main -E UTF8
    sudo -u postgres /usr/lib/postgresql/$PG_MAJOR/bin/postgres --single --config-file=/etc/postgresql/$PG_MAJOR/main/postgresql.conf <<< "ALTER USER postgres WITH PASSWORD '';" > /dev/null
fi

sudo -u postgres "$@"
