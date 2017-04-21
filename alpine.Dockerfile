FROM scratch

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG ID=1000
ARG TZ=Europe/Berlin

#
# Setup
#
ADD alpine.tar.gz /

RUN addgroup -g $ID app && \
    adduser -u $ID -G app -s /bin/ash -D app && \
    mkdir \
        /app \
        /data \
        /var/log/app && \
    chown app:app \
        /app \
        /data \
        /var/log/app && \
    apk --no-cache add \
        tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del \
        tzdata
