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
    php5-cli \
    php5-common \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-imap \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-mongo \
    php5-mysqlnd \
    php5-pgsql \
    php5-phpdbg \
    php5-readline \
    php5-redis \
    php5-sqlite \
    php5-xmlrpc \
    php5-xsl

#
# Configuration
#
COPY www.conf /etc/php5/fpm/pool.d/www.conf
COPY php.ini /etc/php5/mods-available/php.ini

RUN ln -s /etc/php5/mods-available/php.ini /etc/php5/cli/conf.d/90-php.ini && \
    ln -s /etc/php5/mods-available/php.ini /etc/php5/fpm/conf.d/90-php.ini

#
# Ports
#
EXPOSE 4000 8000 9000

#
# Command
#
ENTRYPOINT ["php5-fpm"]
CMD ["-F"]
