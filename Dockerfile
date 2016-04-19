FROM ubuntu:16.04

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=de_DE.UTF-8 \
    TERM=xterm \
    TZ=Europe/Berlin

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    curl \
    git \
    less \
    locales \
    nano \
    wget

RUN rm -rf /var/lib/apt/lists/*

#
# Configuration
#
RUN locale-gen $LANG && \
    update-locale LANG=$LANG

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

#
# Environment
#
ENV DEBIAN_FRONTEND=
