#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed"
    exit 1
fi

AUTHORITY_ID=$1

sui client object $AUTHORITY_ID --json | jq