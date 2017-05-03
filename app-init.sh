#!/bin/sh

set -e

if [ ! -f "/etc/docker-registry/htpasswd" ]; then
    apk add --no-cache apache2-utils
    htpasswd -Bbn $HTUSR $HTPWD > /etc/docker-registry/htpasswd
    apk del apache2-utils
fi
