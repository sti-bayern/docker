FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Build variables
#
ARG DEBIAN_FRONTEND=noninteractive

#
# Setup
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nginx && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\nuser app\ndaemon off;" >> /etc/nginx/nginx.conf && \
    mkdir /home/app/root/public && \
    echo "Hello World" >> /home/app/root/public/index.html && \
    chown -R app:app /home/app/root

COPY default.conf /etc/nginx/sites-available/default
COPY snippets /etc/nginx/snippets

#
# Volumes
#
VOLUME ["/home/app/root"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
