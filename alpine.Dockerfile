FROM akilli/base:alpine

LABEL maintainer "Ayhan Akilli"

#
# Setup
#
RUN apk add --no-cache \
        nginx \
        openssl && \
    rm /etc/nginx/conf.d/default.conf && \
    mkdir /etc/nginx/ssl && \
    openssl dhparam -out /etc/nginx/ssl/dhparam.pem 204

COPY default.conf /app/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY snippets/ /etc/nginx/snippets/

#
# Ports
#
EXPOSE 80 443

#
# Command
#
CMD ["nginx"]
