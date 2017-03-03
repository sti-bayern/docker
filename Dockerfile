FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Setup
#
RUN wget -qO - https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/pkgr/gogs xenial pkgr" > /etc/apt/sources.list.d/gogs.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        gogs && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY app.ini /opt/gogs/custom/conf/app.ini

#
# Volumes
#
VOLUME ["/data"]

#
# Ports
#
EXPOSE 22 3000

#
# Command
#
USER gogs

CMD ["/opt/gogs/gogs", "web"]
