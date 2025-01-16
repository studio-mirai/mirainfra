#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed"
    exit 1
fi

if [ -z "$PACKAGE_ID" ]; then
    echo "Error: PACKAGE_ID environment variable is not set"
    exit 1
fi

NETWORK=$1
ENVIRONMENT=$2
SERVICE=$3
VERSION=$4

if [ -z "$NETWORK" ] || [ -z "$ENVIRONMENT" ] || [ -z "$SERVICE" ] || [ -z "$VERSION" ]; then
    echo "Error: All arguments (NETWORK, ENVIRONMENT, SERVICE, VERSION) must be specified"
    exit 1
fi

RESULT=$(sui client ptb \
    --move-call $PACKAGE_ID::authority::new "'$NETWORK'" "'$ENVIRONMENT'" "'$SERVICE'" "'$VERSION'" \
    --assign authority_cap \
    --move-call 0x2::tx_context::sender \
    --assign sender \
    --transfer-objects "[authority_cap]" sender \
    --json)

echo $RESULT | jq -r '.events[0].parsedJson'