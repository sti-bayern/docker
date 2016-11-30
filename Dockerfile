FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Environment variables
#
ENV USER=app

#
# Setup
#
RUN wget -qO - https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/pkgr/gogs trusty pkgr" > /etc/apt/sources.list.d/gogs.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        gogs && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R app:app /opt/gogs && \
    chown -R app:app /var/log/gogs && \
    deluser --remove-home gogs

COPY app.ini /opt/gogs/custom/conf/app.ini

#
# Volumes
#
VOLUME ["/opt/gogs/data"]

#
# Ports
#
EXPOSE 3000

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
