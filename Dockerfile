FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Environment variables
#
ENV JENKINS_GROUP=app \
    JENKINS_HOME=/data \
    JENKINS_LOG=/var/log/app/jenkins.log \
    JENKINS_URL=https://updates.jenkins-ci.org/latest/jenkins.war \
    JENKINS_USER=app

#
# Setup
#
RUN apk add --no-cache \
        curl \
        docker \
        git \
        openjdk8 \
        py-pip \
        sudo \
        ttf-dejavu && \
    curl -fsSL $JENKINS_URL -o /app/jenkins.war && \
    pip install docker-compose && \
    apk del \
        curl && \
    echo 'app ALL = NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose' >> /etc/sudoers && \
    mkdir /app/cache

#
# Ports
#
EXPOSE 8080

#
# Command
#
CMD ["su-exec", "app", "java", "-Djava.awt.headless=true", "-jar", "/app/jenkins.war", "--webroot=/app/cache", "--httpPort=8080"]
