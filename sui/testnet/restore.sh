#!/bin/bash

TYPE=$1

if [ "$TYPE" == "formal" ]; then
    /opt/sui/testnet/bin/sui-tool download-formal-snapshot \
        --latest \
        --genesis /opt/sui/testnet/config/genesis.blob \
        --network testnet \
        --path /opt/sui/testnet/db \
        --num-parallel-downloads 50 \
        --no-sign-request
elif [ "$TYPE" == "rocksdb" ]; then
    sui-tool download-db-snapshot --latest \
        --network testnet \
        --path /opt/sui/testnet/db \
        --num-parallel-downloads 50 \
        --skip-indexes \
        --no-sign-request
else
    echo "Error: TYPE must be either 'formal' or 'rocksdb'"
    exit 1
fi
