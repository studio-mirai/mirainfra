#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed"
    exit 1
fi

AUTHORITY_ID=$1

curl -X POST \
     -H "Content-Type: application/json" \
     -d '{
           "jsonrpc": "2.0",
           "id": 1,
           "method": "sui_getObject",
           "params": [
             "'$AUTHORITY_ID'",
             {
               "showType": true,
               "showOwner": true,
               "showPreviousTransaction": true,
               "showDisplay": false,
               "showContent": true,
               "showBcs": false,
               "showStorageRebate": true
             }
           ]
         }' \
    "https://fullnode.mainnet.sui.io:443" | jq -r '.result.data'