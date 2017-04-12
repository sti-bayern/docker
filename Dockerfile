FROM akilli/base

LABEL maintainer "Ayhan Akilli"

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
# Setup
#
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E5267A6C && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/php.list && \
    apt-get -y update && \
    apt-get -y --no-install-recommends install \
        php$PHP-bcmath \
        php$PHP-cli \
        php$PHP-common \
        php$PHP-curl \
        php$PHP-fpm \
        php$PHP-gd \
        php$PHP-intl \
        php$PHP-json \
        php$PHP-mbstring \
        php$PHP-mysql \
        php$PHP-opcache \
        php$PHP-pgsql \
        php$PHP-readline \
        php$PHP-soap \
        php$PHP-sqlite3 \
        php$PHP-xml \
        php$PHP-xmlrpc \
        php$PHP-zip && \
    apt-get -y --purge autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/php && \
    ln -s ../../mods-available/php.ini /etc/php/$PHP/cli/conf.d/90-php.ini && \
    ln -s ../../mods-available/php.ini /etc/php/$PHP/fpm/conf.d/90-php.ini

COPY php.ini /etc/php/$PHP/mods-available/php.ini
COPY www.conf /etc/php/$PHP/fpm/pool.d/www.conf

#
# Ports
#
EXPOSE 9000

#
# Command
#
CMD php-fpm$PHP -F
