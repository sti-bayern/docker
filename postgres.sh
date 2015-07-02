#!/bin/bash

chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /run/postgresql

if [ -z "$(ls -A /var/lib/postgresql)" ]
then
    su postgres -c "mkdir -p /var/lib/postgresql/9.4/main"
    su postgres -c "/usr/lib/postgresql/9.4/bin/initdb -D /var/lib/postgresql/9.4/main -E UTF8"
    su postgres -c "/usr/lib/postgresql/9.4/bin/postgres --single --config-file=/etc/postgresql/9.4/main/postgresql.conf" <<< "ALTER USER postgres WITH PASSWORD '';" > /dev/null
fi

su postgres -c "/usr/lib/postgresql/9.4/bin/postgres --config-file=/etc/postgresql/9.4/main/postgresql.conf"
