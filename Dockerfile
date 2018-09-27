FROM akilli/node

LABEL maintainer="Ayhan Akilli"

#
# Setup
#
RUN npm install -g \
        maildev && \
    rm -rf \
        /root/.config \
        /root/.npm

COPY s6/ /etc/s6/

#
# Ports
#
EXPOSE 1025 1080
