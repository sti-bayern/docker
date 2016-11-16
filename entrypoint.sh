#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /run/postgresql

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    su postgres -c "mkdir -p /var/lib/postgresql/$POSTGRES/main"
    su postgres -c "initdb -D /var/lib/postgresql/$POSTGRES/main -E UTF8"
    su postgres -c "postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$POSTGRES_PWD';" > /dev/null
    su postgres -c "postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "CREATE USER app WITH PASSWORD '$POSTGRES_APP_PWD';" > /dev/null
    su postgres -c "postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "CREATE DATABASE app WITH OWNER app ENCODING 'UTF8';" > /dev/null
fi

su postgres -c "postgres --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf"
