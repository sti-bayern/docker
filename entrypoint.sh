#!/bin/bash

set -e

chown -R app:app /app /data /var/cache/jenkins /var/log/jenkins

su -c "java -Djava.awt.headless=true -jar /app/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080" app
