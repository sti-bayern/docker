FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG version=7.1

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
    php$version-bcmath \
    php$version-cli \
    php$version-common \
    php$version-curl \
    php$version-fpm \
    php$version-gd \
    php$version-imap \
    php$version-intl \
    php$version-json \
    php$version-mbstring \
    php$version-mcrypt \
    php$version-mysql \
    php$version-pgsql \
    php$version-readline \
    php$version-soap \
    php$version-sqlite3 \
    php$version-xml \
    php$version-xmlrpc \
    php$version-zip

#
# Configuration
#
COPY www.conf /etc/php/$version/fpm/pool.d/www.conf
COPY php.ini /etc/php/$version/mods-available/php.ini

RUN ln -s /etc/php/$version/mods-available/php.ini /etc/php/$version/cli/conf.d/90-php.ini && \
    ln -s /etc/php/$version/mods-available/php.ini /etc/php/$version/fpm/conf.d/90-php.ini && \
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
CMD php-fpm$version -F
