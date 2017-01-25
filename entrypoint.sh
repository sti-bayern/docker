#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql /run/postgresql
find /var/lib/postgresql -type d -exec chmod 700 {} \;
find /var/lib/postgresql -type f -exec chmod 600 {} \;

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    su -c "mkdir -p /var/lib/postgresql/$PG/main" postgres
    su -c "/usr/lib/postgresql/$PG/bin/initdb -D /var/lib/postgresql/$PG/main -E UTF8" postgres
    su -c "/usr/lib/postgresql/$PG/bin/postgres --single --config-file=/etc/postgresql/$PG/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$PG_ROOT';" postgres
fi

su -c "/usr/lib/postgresql/$PG/bin/postgres --config-file=/etc/postgresql/$PG/main/postgresql.conf" postgres
