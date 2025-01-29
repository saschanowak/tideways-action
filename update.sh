#!/bin/bash

set -euxo pipefail

versions="$(curl -fsSL 'https://app.tideways.io/api/current-versions')"

TIDEWAYS_CLI_VERSION="$(echo "$versions" |jq -r '.cli.version')"
awk \
	-v "TIDEWAYS_CLI_VERSION=$TIDEWAYS_CLI_VERSION" \
	-v "TIDEWAYS_CLI_SHA256_X64=$(curl -fsSL "https://tideways.s3.amazonaws.com/cli/${TIDEWAYS_CLI_VERSION}/tideways-cli_linux_x86_64-${TIDEWAYS_CLI_VERSION}.tar.gz" |sha256sum |cut -d' ' -f1)" \
	-v "TIDEWAYS_CLI_SHA256_ARM64=$(curl -fsSL "https://tideways.s3.amazonaws.com/cli/${TIDEWAYS_CLI_VERSION}/tideways-cli_linux_arm64-${TIDEWAYS_CLI_VERSION}.tar.gz" |sha256sum |cut -d' ' -f1)" \
	'
		$1 == "ENV" { env=1 }
		env {
			for (i=1; i <= NF; i++) {
				split($i, a, "=");
				if (a[1] == "TIDEWAYS_CLI_VERSION") { $i = a[1] "=" TIDEWAYS_CLI_VERSION }
				if (a[1] == "TIDEWAYS_CLI_SHA256_X64") { $i = a[1] "=" TIDEWAYS_CLI_SHA256_X64 }
				if (a[1] == "TIDEWAYS_CLI_SHA256_ARM64") { $i = a[1] "=" TIDEWAYS_CLI_SHA256_ARM64 }
			}
		}
		{ print }
		env && !/\\$/ { env=0 }
	' \
	< cli/Dockerfile > cli/Dockerfile.new
mv -f cli/Dockerfile.new cli/Dockerfile
