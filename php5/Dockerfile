FROM akilli/base

LABEL maintainer="Ayhan Akilli"

#
# Setup
#
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/v3.8/main -X http://dl-cdn.alpinelinux.org/alpine/v3.8/community \
        php5 \
        php5-ctype \
        php5-curl \
        php5-dom \
        php5-fpm \
        php5-gd \
        php5-iconv \
        php5-intl \
        php5-json \
        php5-ldap \
        php5-mcrypt \
        php5-mysql \
        php5-pdo \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-pdo_sqlite \
        php5-opcache \
        php5-pgsql \
        php5-soap \
        php5-sqlite3 \
        php5-xml \
        php5-xmlreader \
        php5-xsl \
        php5-zip \
        php5-zlib && \
    rm -rf /etc/php5/fpm.d

COPY etc/ /etc/

#
# Ports
#
EXPOSE 9000
