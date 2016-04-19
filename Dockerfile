FROM akilli/base

MAINTAINER Ayhan Akilli

#
# Set environment variables
#
ENV DEBIAN_FRONTEND=noninteractive

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

#
# Reset environment variables
#
ENV DEBIAN_FRONTEND=

#
# Volumes
#
VOLUME ["/var/www/html"]

#
# Ports
#
EXPOSE 80 443

#
# Command
#
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
