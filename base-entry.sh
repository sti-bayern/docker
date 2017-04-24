#!/bin/sh

set -e

chown -R app:app /app /data /var/log/app

if [ -n "$SU" ]; then
    su $SU
fi

exec "$@"
