FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Setup
#
COPY app.ini /data/custom/conf/app.ini

RUN wget -qO - https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/pkgr/gogs trusty pkgr" > /etc/apt/sources.list.d/gogs.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        gogs && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p \
        /data/custom/conf \
        /data/gogs \
        /data/git && \
    ln -sf /data/custom /opt/gogs/custom && \
    ln -sf /data/gogs /opt/gogs/data && \
    chown -R gogs:gogs \
        /data \
        /opt/gogs \
        /var/log/gogs

#
# Volumes
#
VOLUME ["/data"]

#
# Ports
#
EXPOSE 3000

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
