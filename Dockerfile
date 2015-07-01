FROM debian:jessie

MAINTAINER Ayhan Akilli

#
# Environment variables
#
ENV DEBIAN_FRONTEND=noninteractive \
    NGINX_ROOT=/var/www/html \
    NGINX_HOST=_

#
# APT packages
#
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    nginx \
    ssl-cert

RUN rm -rf /var/lib/apt/lists/*

#
# Volumes
#
VOLUME ["/var/www/html"]

#
# Configuration
#
COPY default.conf /etc/nginx/conf.d/default.conf
COPY fastcgi.conf /etc/nginx/fastcgi.conf
COPY snippets /etc/nginx/snippets

#
# Log
#
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

#
# Ports
#
EXPOSE 80 443

#
# Command
#
COPY nginx.sh /nginx.sh

ENTRYPOINT ["/nginx.sh"]
