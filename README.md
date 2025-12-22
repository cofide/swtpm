# Software TPM

A container image for software TPM testing.

To build:

```sh
just build
```

To run:

```sh
docker run --detach \
  --name swtpm \
  --label owner=test.cofide-connect \
  --restart unless-stopped \
  --volume /path/to/hashes:/tpmhashes \
  --volume swtpm-sockets:/run/swtpm \
  ghcr.io/cofide/swtpm:latest
```

A Unix socket for interacting with the TPM will be available in the swtpm-sockets volume.
A SHA256 hash of the TPM's Endorsement Key (EK) will be available in `/path/to/hashes/ek-cert.sha256`.
