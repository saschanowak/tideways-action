FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/saschanowak/tideways-action"

ENV TIDEWAYS_CLI_VERSION=1.2.8
ENV TIDEWAYS_CLI_SHA256_X64=788802520ca318327570f5496f7b6e378e55ad01977a06dcc541988f805143f9
ENV TIDEWAYS_CLI_SHA256_ARM64=e20ef35e6cf97bd3e3996579587737ce60e4250ca7ea562f0c7aaa846b1365e8

RUN set -eux; \
	export DEBIAN_FRONTEND="noninteractive"; \
	apt-get update; \
	apt-get install -y --no-install-recommends curl ca-certificates; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		arm64) arch='arm64' checksum="$TIDEWAYS_CLI_SHA256_ARM64" ;; \
		amd64) arch='amd64' checksum="$TIDEWAYS_CLI_SHA256_X64" ;; \
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
