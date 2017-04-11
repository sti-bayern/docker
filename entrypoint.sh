#!/bin/sh

set -e

chown -R app:app /app /data

su -c "/app/gogs web" app
