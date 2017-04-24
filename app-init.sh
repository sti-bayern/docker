#!/bin/sh

set -e

if [ -z "$(ls -A /data)" ]; then
    su-exec app initdb -E UTF8 -U app
    echo "listen_addresses='*'" >> /data/postgresql.conf
    cat > /data/pg_hba.conf << EOF
local   all             all                                     peer
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
host    all             all             172.0.0.1/8             md5
host    all             all             10.0.0.0/8              md5
EOF

    cat << EOF | su-exec app postgres --single postgres
CREATE DATABASE app ENCODING 'UTF8';
ALTER USER app WITH PASSWORD '$PGPASS';
EOF

else
    find /data -type d -exec chmod 700 {} \;
    find /data -type f -exec chmod 600 {} \;
fi
