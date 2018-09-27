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
COPY s6/ /etc/s6/

RUN apk add --no-cache \
        docker \
        git \
        openjdk8 \
        py-pip \
        sudo \
        ttf-dejavu && \
    wget -O /app/jenkins.war $JENKINS_URL && \
    pip install docker-compose && \
    echo 'app ALL = NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose' >> /etc/sudoers && \
    mkdir /app/cache

#
# Ports
#
EXPOSE 8080
