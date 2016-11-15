FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

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

RUN echo "\nuser app\ndaemon off;" >> /etc/nginx/nginx.conf && \
    mkdir /home/app/www/public && \
    echo "Hello World" >> /home/app/www/public/index.html && \
    chown -R app:app /home/app/www

#
# Volumes
#
VOLUME ["/home/app/www"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
