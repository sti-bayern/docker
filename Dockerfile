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
ADD ubuntu.tar.gz /

RUN groupadd -g $ID app && \
    useradd -u $ID -g app -m app && \
    mkdir \
        /app \
        /data \
        /var/log/app && \
    chown app:app \
        /app \
        /data \
        /var/log/app && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        locales \
        tzdata && \
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
        /var/lib/apt/lists/* \
        /var/log/*log
