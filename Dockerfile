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
    mkdir /app/public && \
    echo "Hello World" >> /app/public/index.html && \
    chown -R app:app /app

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/sites-available/default
COPY snippets /etc/nginx/snippets

#
# Volumes
#
VOLUME ["/app"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
