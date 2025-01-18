#!/bin/bash

TYPE=$1

if [ "$TYPE" == "formal" ]; then
    /opt/sui/mainnet/bin/sui-tool download-formal-snapshot \
        --latest \
        --genesis /opt/sui/mainnet/config/genesis.blob \
        --network mainnet \
        --path /opt/sui/mainnet/db \
        --num-parallel-downloads 50 \
        --no-sign-request
elif [ "$TYPE" == "rocksdb" ]; then
    sui-tool download-db-snapshot --latest \
        --network mainnet \
        --path /opt/sui/mainnet/db \
        --num-parallel-downloads 50 \
        --skip-indexes \
        --no-sign-request
else
    echo "Error: TYPE must be either 'formal' or 'rocksdb'"
    exit 1
fi
