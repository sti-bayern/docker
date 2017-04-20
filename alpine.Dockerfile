FROM scratch

LABEL maintainer "Ayhan Akilli"

#
# Build variables
#
ARG TZ=Europe/Berlin
ARG UID=1000

#
# Setup
#
ADD alpine.tar.gz /

RUN adduser -u $UID -H -D app app && \
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
    apk del tzdata

