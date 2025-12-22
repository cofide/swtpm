# Build the swtpm image
build:
	#!/usr/bin/env bash
	set -euo pipefail
	docker buildx build --load -f Dockerfile . -t ghcr.io/cofide/swtpm:latest
