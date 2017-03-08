FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG GO=1.8
ARG GOPATH=/usr/local/gogs
ARG GOROOT=/usr/local/go
ARG GOGSPATH=$GOPATH/src/github.com/gogits/gogs

#
# Environment variables
#
ENV GOGS_CUSTOM=/data/custom

#
# Setup
#
COPY app.ini /data/custom/conf/app.ini

RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        build-essential \
        sqlite3 && \
    curl -O https://storage.googleapis.com/golang/go$GO.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go$GO.linux-amd64.tar.gz && \
    PATH=$PATH:/usr/local/go/bin && \
    go get -v -u -tags sqlite github.com/gogits/gogs && \
    cd $GOGSPATH && \
    CGO_ENABLED=1 GOOS=linux go build -a -tags sqlite -installsuffix cgo -o /app/gogs . && \
    apt-get -y --purge remove \
        build-essential && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    mv conf /app && \
    mv public /app && \
    mv templates /app && \
    rm -rf \
       $GOPATH \
       go$GO.linux-amd64.tar.gz \
       /app/public/less \
       /usr/local/go && \
    mkdir -p \
        /app/log \
        /data/git \
        /data/gogs && \
    chown -R app:app \
        /app \
        /data

#
# Volumes
#
VOLUME ["/data"]

#
# Ports
#
EXPOSE 3000

#
# Command
#
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
