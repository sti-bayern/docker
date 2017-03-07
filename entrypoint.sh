#!/bin/bash

set -e

chown -R gogs:gogs /data /opt/gogs /var/log/gogs

su -c "/opt/gogs/gogs web" gogs
