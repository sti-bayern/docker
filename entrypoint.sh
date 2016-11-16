#!/bin/bash

set -e

chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /run/postgresql

if [ -z "$(ls -A /var/lib/postgresql)" ]; then
    su postgres -c "mkdir -p /var/lib/postgresql/$POSTGRES/main"
    su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/initdb -D /var/lib/postgresql/$POSTGRES/main -E UTF8"
    su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '$POSTGRES_PWD';"
    su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "CREATE USER app WITH PASSWORD '$POSTGRES_APP_PWD';"
    su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "CREATE DATABASE app WITH OWNER app ENCODING 'UTF8';"
    su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/postgres --single --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf" <<< "GRANT ALL PRIVILEGES ON DATABASE app TO app;"
fi

su postgres -c "/usr/lib/postgresql/$POSTGRES/bin/postgres --config-file=/etc/postgresql/$POSTGRES/main/postgresql.conf"
