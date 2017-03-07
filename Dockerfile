FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG DC=1.11.2

#
# Environment variables
#
ENV JENKINS_HOME=/app \
    JENKINS_GROUP=app \
    JENKINS_USER=app

#
# Setup
#
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && \
    echo "deb https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        docker-engine \
        jenkins && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L https://github.com/docker/compose/releases/download/$DC/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    usermod -aG docker app && \
    chown -R app:app \
        /app \
        /var/cache/jenkins \
        /var/log/jenkins
#
# Volumes
#
VOLUME ["/app"]

#
# Ports
#
EXPOSE 8080

#
# Command
#
USER app

CMD ["java", "-Djava.awt.headless=true", "-jar", "/usr/share/jenkins/jenkins.war", "--webroot=/var/cache/jenkins/war", "--httpPort=8080"]
