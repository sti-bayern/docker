#!/bin/sh

set -e

chown -R app:app /app /data

exec "$@"
