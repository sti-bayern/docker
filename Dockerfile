FROM ubuntu:16.04

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG LANG=de_DE.UTF-8
ARG TERM=xterm
ARG TZ=Europe/Berlin
ARG USER_UID=1000
ARG USER_GID=1000

#
# Environment variables
#
ENV LANG=$LANG \
    TERM=$TERM \
    TZ=$TZ

#
# Setup
#
RUN groupadd -r -g $USER_GID app && \
    useradd -r -u $USER_UID -g app -m app && \
    mkdir /app && \
    chown app:app /app && \
    locale-gen $LANG && \
    update-locale LANG=$LANG && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        apt-utils \
        curl \
        git \
        iputils-ping \
        iputils-tracepath \
        less \
        nano \
        net-tools \
        openssl \
        software-properties-common \
        ssl-cert \
        wget && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
