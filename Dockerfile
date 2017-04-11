FROM scratch

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG ID=1000
ARG LANG=de_DE.UTF-8
ARG TERM=xterm
ARG TZ=Europe/Berlin

#
# Environment variables
#
ENV LANG=$LANG \
    TERM=$TERM

#
# Setup
#
ADD rootfs.tar.gz /

RUN groupadd -r -g $ID app && \
    useradd -r -u $ID -g app -M app && \
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
    unlink /etc/localtime && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get -y --purge remove \
        tzdata && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf \
        /var/cache/* \
        /var/lib/apt/lists/*
