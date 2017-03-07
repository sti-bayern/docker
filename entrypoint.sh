#!/bin/bash

set -e

chown -R app:app /app /usr/share/jenkins /var/cache/jenkins /var/log/jenkins

su -c "java -Djava.awt.headless=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080" app
