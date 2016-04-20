FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Set environment variables
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
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-imap \
    php7.0-intl \
    php7.0-json \
    php7.0-mysql \
    php7.0-pgsql \
    php7.0-phpdbg \
    php7.0-readline \
    php7.0-soap \
    php7.0-sqlite3 \
    php7.0-xml \
    php7.0-xmlrpc \
    php7.0-zip

#
# Configuration
#
COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf
COPY php.ini /etc/php/7.0/mods-available/php.ini

RUN ln -s /etc/php/7.0/mods-available/php.ini /etc/php/7.0/cli/conf.d/90-php.ini && \
    ln -s /etc/php/7.0/mods-available/php.ini /etc/php/7.0/fpm/conf.d/90-php.ini && \
    ln -s /etc/php/7.0/mods-available/php.ini /etc/php/7.0/phpdbg/conf.d/90-php.ini && \
    mkdir -p /run/php

#
# Composer
#
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

#
# Reset environment variables
#
ENV DEBIAN_FRONTEND=

#
# Ports
#
EXPOSE 4000 8000 9000

#
# Command
#
CMD ["php-fpm7.0", "-F"]
