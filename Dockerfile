FROM ubuntu:16.04

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG LANG=de_DE.UTF-8
ARG TERM=xterm
ARG TZ=Europe/Berlin

#
# Environment variables
#
ENV LANG=$LANG \
    TERM=$TERM \
    TZ=$TZ

#
# User
#
RUN groupadd -r -g 1000 app && \
    useradd -r -u 1000 -g app -m app && \
    mkdir /home/app/www && \
    chown app:app /home/app/www

#
# Locale
#
RUN locale-gen $LANG && \
    update-locale LANG=$LANG && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

#
# APT packages
#
RUN apt-get update && apt-get install -y \
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
    rm -rf /var/lib/apt/lists/*
