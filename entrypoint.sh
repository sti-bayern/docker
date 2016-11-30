#!/bin/bash

set -e

chown -R app:app /opt/gogs

su app -c "/opt/gogs/gogs web"
