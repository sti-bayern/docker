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

#
# Ports
#
EXPOSE 1025 1080

#
# Command
#
CMD ["su-exec", "app", "maildev"]
