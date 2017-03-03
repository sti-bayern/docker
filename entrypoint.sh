#!/bin/bash

set -e

chown -R gogs:gogs /data

su -c "/opt/gogs/gogs web" gogs
