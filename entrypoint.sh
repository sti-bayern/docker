#!/bin/sh

set -e

chown -R app:app /app /data /var/cache/jenkins /var/log/app

su -c "java -Djava.awt.headless=true -jar /app/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080" app
