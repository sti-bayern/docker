FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

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
    php7.1-bcmath \
    php7.1-cli \
    php7.1-common \
    php7.1-curl \
    php7.1-fpm \
    php7.1-gd \
    php7.1-imap \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-pgsql \
    php7.1-readline \
    php7.1-soap \
    php7.1-sqlite3 \
    php7.1-xml \
    php7.1-xmlrpc \
    php7.1-zip

#
# Configuration
#
COPY php.ini /etc/php/7.1/mods-available/php.ini
COPY www.conf /etc/php/7.1/fpm/pool.d/www.conf

RUN ln -s /etc/php/7.1/mods-available/php.ini /etc/php/7.1/cli/conf.d/90-php.ini && \
    ln -s /etc/php/7.1/mods-available/php.ini /etc/php/7.1/fpm/conf.d/90-php.ini && \
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
CMD php-fpm7.1 -F
