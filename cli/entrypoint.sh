#!/bin/bash
set -e pipefail

die() {
    echo "$@" >&2
    exit 1
}

if [ -z "$TIDEWAYS_API_KEY" ]; then
    die "TIDEWAYS_API_KEY is not set. Quitting."
fi
if [ -z "$TIDEWAYS_APP_NAME" ]; then
    die "TIDEWAYS_APP_NAME is not set. Quitting."
fi
if [ -z "$TIDEWAYS_TITLE" ]; then
    die "TIDEWAYS_TITLE is not set. Quitting."
fi

EVENT_TYPE=${TIDEWAYS_EVENT_TYPE:-release}
DESCRIPTION=${TIDEWAYS_DESCRIPTION:-}
ENVIRONMENT=${TIDEWAYS_ENVIRONMENT:-production}
SERVICE=${TIDEWAYS_SERVICE:-}
COMPARE_AFTER_MINUTES=${TIDEWAYS_COMPARE_AFTER_MINUTES:-90}

# Import API Key
tideways import ${TIDEWAYS_API_KEY}
if [ -n "$SERVICE" ]; then
    set -- tideways event create -e="${ENVIRONMENT}" -m="${COMPARE_AFTER_MINUTES}" -d="${DESCRIPTION}" -s="${SERVICE}" $TIDEWAYS_APP_NAME $EVENT_TYPE "$TIDEWAYS_TITLE"
else
  set -- tideways event create -e="${ENVIRONMENT}" -m="${COMPARE_AFTER_MINUTES}" -d="${DESCRIPTION}" $TIDEWAYS_APP_NAME $EVENT_TYPE "$TIDEWAYS_TITLE"
fi
exec "$@"
