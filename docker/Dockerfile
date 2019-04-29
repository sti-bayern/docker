FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Setup
#
RUN apk add --no-cache \
        curl \
        docker \
        py-pip \
        sudo && \
    apk add --no-cache --virtual .deps \
        gcc \
        libc-dev \
        libffi-dev \
        make \
        openssl-dev \
        python-dev && \
    pip install docker-compose && \
    apk del \
        .deps && \
    echo 'app ALL = NOPASSWD: /usr/bin/docker, /usr/bin/docker-compose' >> /etc/sudoers
