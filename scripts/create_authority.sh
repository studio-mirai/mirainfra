#!/bin/bash

if [ -z "$PACKAGE_ID" ]; then
    echo "Error: PACKAGE_ID environment variable is not set"
    exit 1
fi

NETWORK=$1
ENVIRONMENT=$2
SERVICE=$3
VERSION=$4

sui client ptb \
    --move-call $PACKAGE_ID::authority::new "'$NETWORK'" "'$ENVIRONMENT'" "'$SERVICE'" "'$VERSION'" \
    --assign authority_cap \
    --move-call 0x2::tx_context::sender \
    --assign sender \
    --transfer-objects "[authority_cap]" sender \
    --json