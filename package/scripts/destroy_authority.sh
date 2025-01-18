#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed"
    exit 1
fi

if [ -z "$PACKAGE_ID" ]; then
    echo "Error: PACKAGE_ID environment variable is not set"
    exit 1
fi

AUTHORITY_ID=$1
AUTHORITY_CAP_ID=$2

if [ -z "$AUTHORITY_ID" ] || [ -z "$AUTHORITY_CAP_ID" ]; then
    echo "Error: All arguments (AUTHORITY_ID, AUTHORITY_CAP_ID) must be specified"
    exit 1
fi

RESULT=$(sui client ptb \
    --move-call $PACKAGE_ID::authority::destroy @$AUTHORITY_ID @$AUTHORITY_CAP_ID \
    --json)

echo $RESULT | jq -r '.events[0].parsedJson'