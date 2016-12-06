#!/bin/bash

set -e

chown -R app:app /app /opt/gogs /var/log/gogs

su app -c "/opt/gogs/gogs web"
