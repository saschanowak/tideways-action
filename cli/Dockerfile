FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/saschanowak/tideways-action"

ENV TIDEWAYS_CLI_VERSION=1.2.6
ENV TIDEWAYS_CLI_SHA256_X64=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
ENV TIDEWAYS_CLI_SHA256_ARM64=043b6eb77a0923d76620befb4780611959c426b323d1355d3543643bb9227b5d

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		curl ca-certificates \
	; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		arm64) arch='arm64' checksum="$TIDEWAYS_CLI_SHA256_ARM64" ;; \
		amd64) arch='x86_64' checksum="$TIDEWAYS_CLI_SHA256_X64" ;; \
		*) echo >&2 "error: unsupported architecture: $dpkgArch"; exit 1 ;; \
	esac; \
	\
	curl -fsSL "https://tideways.s3.amazonaws.com/cli/${TIDEWAYS_CLI_VERSION}/tideways-cli_linux_${arch}-${TIDEWAYS_CLI_VERSION}.tar.gz" -o tideways-cli.tar.gz; \
	echo "$checksum *tideways-cli.tar.gz" |sha256sum -c; \
	mkdir -p /tmp/tideways/; \
	tar xvf tideways-cli.tar.gz --strip-components=1 -C /tmp/tideways/; \
	chmod +x /tmp/tideways/tideways; \
	cp /tmp/tideways/tideways /usr/local/bin/; \
	\
	rm -r /tmp/tideways/; \
	rm tideways-cli.tar.gz; \
	apt-get purge -y --auto-remove; \
	rm -rf /var/lib/apt/lists/*;

COPY --chmod=0755 entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["tideways"]
