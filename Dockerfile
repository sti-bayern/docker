FROM akilli/base

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG GOGS=0.11.4

#
# Environment variables
#
ENV GOGS_CUSTOM=/data/custom

#
# Setup
#
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        git \
        sqlite3 && \
    curl -fsSL https://dl.gogs.io/$GOGS/linux_amd64.tar.gz -o /tmp/gogs.tag.gz && \
    tar -xzf /tmp/gogs.tag.gz -C /app/ --strip 1 && \
    apt-get -y --purge remove \
        ca-certificates \
        curl && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf \
       /app/public/less \
       /tmp/gogs.tag.gz \
       /var/lib/apt/lists/* && \
    mkdir \
        /data/git \
        /data/gogs

COPY app.ini /data/conf/app.ini

#
# Ports
#
EXPOSE 3000

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
