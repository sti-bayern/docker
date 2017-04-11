#!/bin/sh

set -e

chown -R app:app $PGCONF $PGDATA /run/postgresql /var/log/postgresql
find $PGDATA -type d -exec chmod 700 {} \;
find $PGDATA -type f -exec chmod 600 {} \;
opt="--config-file=$PGCONF/postgresql.conf -D $PGDATA"

if [ -z "$(ls -A $PGDATA)" ]; then
    su -c "$PGBIN/initdb -E UTF8 -U app -D $PGDATA" app

    sql="CREATE DATABASE app ENCODING 'UTF8';"
    su -c "echo '$sql' | $PGBIN/postgres --single $opt postgres" app

    sql="ALTER USER app WITH PASSWORD '$PGPASS';"
    su -c "echo '$sql' | $PGBIN/postgres --single $opt" app
fi

su -c "$PGBIN/postgres $opt" app
