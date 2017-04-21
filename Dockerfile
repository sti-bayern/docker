FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
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
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
        curl \
        openjdk-8-jdk-headless && \
    mkdir -p /var/cache/app && \
    curl -fsSL $JENKINS_URL -o /app/jenkins.war && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu yakkety edge" > /etc/apt/sources.list.d/docker.list && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        docker-ce && \
    curl -L https://github.com/docker/compose/releases/download/$DC/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get -y --purge remove \
        apt-transport-https \
        curl && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -aG docker app

#
# Ports
#
EXPOSE 8080

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
