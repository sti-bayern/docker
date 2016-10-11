FROM ubuntu:16.04

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Set environment variables
#
ENV LANG=de_DE.UTF-8 \
    TERM=xterm \
    TZ=Europe/Berlin

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    curl \
    git \
    iputils-ping \
    less \
    locales \
    nano \
    net-tools \
    openssl \
    ssl-cert \
    wget

RUN rm -rf /var/lib/apt/lists/*

#
# Configuration
#
RUN locale-gen $LANG && \
    update-locale LANG=$LANG

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone
