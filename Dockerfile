FROM ghcr.io/stefanberger/swtpm:latest

# To download and use tpm2-tools, we have to enable 
# Alpine Linux's community repositories in apk
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk add gnutls-utils libtool tpm2-tools tpm2-tss-dev tpm2-tss-tcti-swtpm && \
    rm -rf /var/cache/apk/*

COPY /run-swtpm.sh /usr/local/bin/run-swtpm.sh
RUN chmod 755 /usr/local/bin/run-swtpm.sh

ENTRYPOINT ["/usr/local/bin/run-swtpm.sh"]
