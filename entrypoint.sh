#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql /run/postgresql
find /var/lib/postgresql -type d -exec chmod 700 {} \;
find /var/lib/postgresql -type f -exec chmod 600 {} \;

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    su postgres -c "mkdir -p /var/lib/postgresql/$PG/main"
    su postgres -c "/usr/lib/postgresql/$PG/bin/initdb -D /var/lib/postgresql/$PG/main -E UTF8"
    su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --single --config-file=/etc/postgresql/$PG/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$PG_ROOT';"
fi

su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --config-file=/etc/postgresql/$PG/main/postgresql.conf"
