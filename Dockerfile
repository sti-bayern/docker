FROM debian:jessie

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive

#
# User
#
RUN groupmod -g 1000 www-data && \
    usermod -u 1000 www-data

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    curl \
    git

RUN curl http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list && \
    echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.list

RUN apt-get update && apt-get install -y \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-imap \
    php7.0-intl \
    php7.0-json \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-pgsql \
    php7.0-phpdbg \
    php7.0-readline \
    php7.0-sqlite3 \
    php7.0-xmlrpc

#
# Configuration
#
COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY php.ini /etc/php/mods-available/php.ini

RUN ln -s /etc/php/mods-available/php.ini /etc/php/7.0/cli/conf.d/90-php.ini && \
    ln -s /etc/php/mods-available/php.ini /etc/php/7.0/fpm/conf.d/90-php.ini && \
    mkdir -p /run/php

#
# Composer
#
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

#
# Ports
#
EXPOSE 4000 8000 9000

#
# Command
#
ENTRYPOINT ["php-fpm7.0"]
CMD ["-F"]
