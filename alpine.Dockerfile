FROM akilli/base:alpine

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG GOGS=github.com/gogits/gogs
ARG GOPATH=/tmp/go

#
# Environment variables
#
ENV GOGS_CUSTOM=/data/custom

#
# Setup
#
RUN apk add --no-cache \
        git \
        sqlite && \
    apk add --no-cache --virtual .deps \
        build-base \
        go && \
    go get -v -u -tags sqlite $GOGS && \
    cd $GOPATH/src/$GOGS && \
    CGO_ENABLED=1 GOOS=linux go build -a -tags sqlite -installsuffix cgo -o /app/gogs . && \
    mv conf /app && \
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
