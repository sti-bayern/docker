#!/bin/sh

set -e

chown -R app:app /app /data

su -c "/app/gogs web -c /data/conf/app.ini" app
