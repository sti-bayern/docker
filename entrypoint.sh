#!/bin/sh

set -e

chown -R app:app /app /data /var/log/app
mkdir -p /tmp/app

su -c "java -Djava.awt.headless=true -jar /app/jenkins.war --webroot=/tmp/app --httpPort=8080" app
