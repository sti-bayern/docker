#!/bin/sh

set -e

chown -R app:app /app /data /var/cache/app /var/log/app

su -c "java -Djava.awt.headless=true -jar /app/jenkins.war --webroot=/var/cache/app --httpPort=8080" app
