FROM debian:jessie

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive \
    PHP_TAG=master

#
# User
#
RUN groupmod -g 1000 www-data && \
    usermod -u 1000 www-data

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    bison \
    btrfs-tools \
    build-essential \
    curl \
    git \
    libbz2-dev \
    libc-client2007e-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libjpeg-dev \
    libkrb5-dev \
    libmcrypt-dev \
    libpcre3-dev \
    libpng12-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    pkgconf \
    re2c

RUN rm -rf /var/lib/apt/lists/*

#
# Installation
#
RUN git clone --depth 1 -b $PHP_TAG https://github.com/php/php-src.git /usr/src/php

WORKDIR /usr/src/php
RUN ./buildconf --force && ./configure \
    --prefix=/usr \
    --with-config-file-path=/etc/php5/fpm \
    --with-config-file-scan-dir=/etc/php5/fpm/conf.d \
    --enable-fpm \
    --disable-short-tags \
    --enable-bcmath \
    --enable-calendar \
    --enable-cli \
    --enable-debug \
    --enable-exif \
    --enable-ftp \
    --enable-gd-native-ttf \
    --enable-intl \
    --enable-mbstring \
    --enable-pcntl \
    --enable-shmop \
    --enable-soap \
    --enable-sockets \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-wddx \
    --enable-xmlreader \
    --enable-zip \
    --with-bz2=/usr \
    --with-curl \
    --with-gd \
    --with-gettext \
    --with-iconv-dir=/usr \
    --with-imap \
    --with-imap-ssl \
    --with-jpeg-dir=/usr \
    --with-kerberos \
    --with-libxml-dir=/usr \
    --with-mcrypt \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-openssl \
    --with-openssl-dir=/usr \
    --with-pdo-mysql=mysqlnd \
    --with-png-dir=/usr \
    --with-regex \
    --with-xmlrpc \
    --with-xsl \
    --with-zlib \
    --with-zlib-dir=/usr \
    --without-pear

RUN make -j4 && \
    make install

WORKDIR /

#
# Configuration
#
COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY php.ini /etc/php5/fpm/conf.d/90-php.ini
COPY www.conf /etc/php5/fpm/pool.d/www.conf

RUN cp /usr/src/php/php.ini-development /etc/php5/fpm/php.ini && \
    rm -rf /usr/src/php

#
# Composer
#
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

#
# Log
#
RUN ln -sf /dev/stdout /var/log/php5-fpm.log

#
# Ports
#
EXPOSE 9000 9001

#
# Command
#
ENTRYPOINT ["php-fpm"]
CMD ["-F", "-y", "/etc/php5/fpm/php-fpm.conf"]
