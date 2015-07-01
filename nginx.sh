#!/bin/bash

sed -i "s#{{ root }}#$NGINX_ROOT#" /etc/nginx/sites-available/default.conf
sed -i "s#{{ host }}#$NGINX_HOST#" /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"
