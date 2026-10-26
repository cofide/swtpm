FROM ghcr.io/stefanberger/swtpm:latest

# To download and use tpm2-tools, we have to enable 
# Alpine Linux's community repositories in apk
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk add gnutls-utils libtool tpm2-tools tpm2-tss-dev tpm2-tss-tcti-swtpm && \
    rm -rf /var/cache/apk/*

# The base image only ships the ca-certificates-bundle and is stale: it still
# trusts the eMudhra roots. Explicitly take the latest ca-certificates so the
# trust store reflects current Mozilla removals, and fail the build if the
# compromised emSign ECC G3 root is still trusted.
RUN apk add --no-cache --upgrade ca-certificates ca-certificates-bundle && \
    update-ca-certificates && \
    ! ls /etc/ssl/certs | grep -qi 'emSign_ECC_Root_CA_-_G3'

COPY /run-swtpm.sh /usr/local/bin/run-swtpm.sh
RUN chmod 755 /usr/local/bin/run-swtpm.sh

ENTRYPOINT ["/usr/local/bin/run-swtpm.sh"]
