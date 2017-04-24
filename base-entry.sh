#!/bin/sh

set -e

chown -R app:app /app /data /var/cache/app /var/log/app

exec "$@"
