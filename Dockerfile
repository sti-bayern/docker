FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG php=7.1

#
# Environment variables
#
ENV php=$php

#
# User
#
RUN groupmod -g 1000 www-data && \
    usermod -u 1000 www-data

#
# APT packages
#
RUN apt-get update && apt-get install -y \
    software-properties-common

RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y \
    php$php-bcmath \
    php$php-cli \
    php$php-common \
    php$php-curl \
    php$php-fpm \
    php$php-gd \
    php$php-imap \
    php$php-intl \
    php$php-json \
    php$php-mbstring \
    php$php-mysql \
    php$php-pgsql \
    php$php-readline \
    php$php-soap \
    php$php-sqlite3 \
    php$php-xml \
    php$php-xmlrpc \
    php$php-zip

#
# Configuration
#
COPY php.ini /etc/php/$php/mods-available/php.ini
COPY www.conf /etc/php/$php/fpm/pool.d/www.conf

RUN ln -s /etc/php/$php/mods-available/php.ini /etc/php/$php/cli/conf.d/90-php.ini && \
    ln -s /etc/php/$php/mods-available/php.ini /etc/php/$php/fpm/conf.d/90-php.ini && \
    mkdir -p /run/php

#
# Composer
#
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

#
# Ports
#
EXPOSE 9000

#
# Command
#
CMD php-fpm$php -F
