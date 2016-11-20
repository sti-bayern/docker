FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive
ARG PHP=7.1

#
# Environment variables
#
ENV PHP=$PHP

#
# APT packages
#
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y \
    php$PHP-bcmath \
    php$PHP-cli \
    php$PHP-common \
    php$PHP-curl \
    php$PHP-fpm \
    php$PHP-gd \
    php$PHP-imap \
    php$PHP-intl \
    php$PHP-json \
    php$PHP-mbstring \
    php$PHP-mysql \
    php$PHP-pgsql \
    php$PHP-readline \
    php$PHP-soap \
    php$PHP-sqlite3 \
    php$PHP-xml \
    php$PHP-xmlrpc \
    php$PHP-zip && \
    rm -rf /var/lib/apt/lists/*

#
# Configuration
#
COPY php.ini /etc/php/$PHP/mods-available/php.ini
COPY www.conf /etc/php/$PHP/fpm/pool.d/www.conf

RUN ln -s /etc/php/$PHP/mods-available/php.ini /etc/php/$PHP/cli/conf.d/90-php.ini && \
    ln -s /etc/php/$PHP/mods-available/php.ini /etc/php/$PHP/fpm/conf.d/90-php.ini && \
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
CMD php-fpm$PHP -F
