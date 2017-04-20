#!/bin/sh

set -e

chown -R app:app $PGDATA /run/postgresql /var/log/postgresql

if [ -z "$(ls -A $PGDATA)" ]; then
    su -c "initdb -E UTF8 -U app" app
    echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
    cat > $PGDATA/pg_hba.conf << EOF
local   all             all                                     peer
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
host    all             all             172.0.0.1/8             md5
host    all             all             10.0.0.0/8              md5
EOF

    cat << EOF | su -c "postgres --single postgres" app
CREATE DATABASE app ENCODING 'UTF8';
ALTER USER app WITH PASSWORD '$PGPASS';
EOF

else
    find $PGDATA -type d -exec chmod 700 {} \;
    find $PGDATA -type f -exec chmod 600 {} \;
fi

su -c postgres app
