FROM ubuntu

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG LANG=de_DE.UTF-8
ARG TERM=xterm
ARG TZ=Europe/Berlin
ARG UID=1000

#
# Environment variables
#
ENV LANG=$LANG \
    TERM=$TERM \
    TZ=$TZ

#
# Setup
#
RUN useradd -r -u $UID -U -M app && \
    mkdir \
        /app \
        /data \
        /var/log/app && \
    chown app:app \
        /app \
        /data \
        /var/log/app && \
    locale-gen $LANG && \
    update-locale LANG=$LANG && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get -y remove \
        tzdata && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
