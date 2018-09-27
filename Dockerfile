FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Build variables
#
ARG GOGS=github.com/gogs/gogs
ARG GOPATH=/tmp/go

#
# Environment variables
#
ENV GOGS_CUSTOM=/data/custom \
    USER=app

#
# Setup
#
RUN apk add --no-cache \
        bash \
        git \
        sqlite && \
    apk add --no-cache --virtual .deps \
        build-base \
        go && \
    go get -v -u -tags sqlite $GOGS && \
    cd $GOPATH/src/$GOGS && \
    CGO_ENABLED=1 GOOS=linux go build -a -tags sqlite -installsuffix cgo -ldflags="-s -w" -o /app/gogs . && \
    mv public /app && \
    mv templates /app && \
    apk del \
        .deps && \
    rm -rf \
       /app/public/less \
       /tmp/* && \
    mkdir \
        /data/git \
        /data/gogs

COPY rootfs/ /

#
# Ports
#
EXPOSE 3000
