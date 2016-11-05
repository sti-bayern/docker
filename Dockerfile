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
    nginx

RUN rm -rf /var/lib/apt/lists/*

#
# Configuration
#
COPY default.conf /etc/nginx/sites-available/default
COPY snippets /etc/nginx/snippets

RUN  echo "\ndaemon off;" >> /etc/nginx/nginx.conf

#
# Volumes
#
VOLUME ["/srv"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
