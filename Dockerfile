FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Environment variables
#
ENV JENKINS_HOME=/home/app/root

#
# Setup
#
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && \
    echo "deb https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list && \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        docker-engine \
        jenkins && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -aG docker app && \
    chown -R app:app /var/cache/jenkins
#
# Volumes
#
VOLUME ["/home/app/root"]

#
# Ports
#
EXPOSE 8080

#
# Command
#
USER app

CMD ["java", "-Djava.awt.headless=true", "-jar", "/usr/share/jenkins/jenkins.war", "--webroot=/var/cache/jenkins/war", "--httpPort=8080"]
