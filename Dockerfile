FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Setup
#
RUN apk add --no-cache \
        git \
        nodejs-current \
        nodejs-current-npm
