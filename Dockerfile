FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DC=1.12.0

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
        openjdk8 \
        sudo \
        ttf-dejavu && \
    curl -fsSL $JENKINS_URL -o /app/jenkins.war && \
    curl -L https://github.com/docker/compose/releases/download/$DC/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apk del \
        curl && \
    echo 'jenkins ALL=(ALL) NOPASSWD: /usr/local/bin/docker, /usr/local/bin/docker-compose' >> /etc/sudoers

#
# Ports
#
EXPOSE 8080

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
