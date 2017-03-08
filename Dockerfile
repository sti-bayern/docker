FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG DC=1.11.2

#
# Environment variables
#
ENV JENKINS_HOME=/data \
    JENKINS_GROUP=app \
    JENKINS_URL=https://updates.jenkins-ci.org/latest/jenkins.war \
    JENKINS_USER=app

#
# Setup
#
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        docker-ce \
        openjdk-8-jdk-headless && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p \
        /data \
        /var/cache/jenkins/war \
        /var/log/jenkins && \
    curl -fsSL $JENKINS_URL -o /app/jenkins.war && \
    curl -L https://github.com/docker/compose/releases/download/$DC/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    usermod -aG docker app && \
    chown -R app:app \
        /app \
        /data \
        /var/cache/jenkins \
        /var/log/jenkins
#
# Volumes
#
VOLUME ["/data"]

#
# Ports
#
EXPOSE 8080

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
