#!/bin/sh

set -e

chown -R app:app /app /data /var/log/app

if [ -n "$(which app-init)" ]; then
    app-init
fi

exec "$@"
