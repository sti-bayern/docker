#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql /run/postgresql

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    su postgres -c "mkdir -p /var/lib/postgresql/$PG/main"
    su postgres -c "/usr/lib/postgresql/$PG/bin/initdb -D /var/lib/postgresql/$PG/main -E UTF8"
    su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --single --config-file=/etc/postgresql/$PG/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$PG_ROOT';"
    su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --single --config-file=/etc/postgresql/$PG/main/postgresql.conf" <<< "CREATE USER app WITH PASSWORD '$PG_APP' SUPERUSER;"
    su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --single --config-file=/etc/postgresql/$PG/main/postgresql.conf" <<< "CREATE DATABASE app WITH OWNER app ENCODING 'UTF8';"
fi

su postgres -c "/usr/lib/postgresql/$PG/bin/postgres --config-file=/etc/postgresql/$PG/main/postgresql.conf"
