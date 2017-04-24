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
ADD rootfs.tar.gz /

RUN addgroup -g $ID app && \
    adduser -u $ID -G app -s /bin/ash -D app && \
    mkdir \
        /app \
        /data \
        /var/log/app && \
    apk --no-cache add \
        tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del \
        tzdata

#
# Command
#
COPY base-entry.sh /usr/local/bin/base-entry

ENTRYPOINT ["base-entry"]
CMD ["ash"]
