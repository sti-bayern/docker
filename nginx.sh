#!/bin/bash

sed -i "s#{{ root }}#$NGINX_ROOT#" /etc/nginx/conf.d/default.conf
sed -i "s#{{ host }}#$NGINX_HOST#" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
