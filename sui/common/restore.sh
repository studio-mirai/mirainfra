#!/bin/bash

NETWORK=$1
TYPE=$2

if [ "$NETWORK" != "mainnet" ] && [ "$NETWORK" != "testnet" ]; then
    echo "Error: NETWORK must be either 'mainnet' or 'testnet'"
    exit 1
fi

if [ "$TYPE" != "formal" ] && [ "$TYPE" != "rocksdb" ]; then
    echo "Error: TYPE must be either 'formal' or 'rocksdb'"
    exit 1
fi

    
if [ "$TYPE" == "formal" ]; then
    /opt/sui/bin/sui-tool download-formal-snapshot \
        --latest \
        --genesis /opt/sui/config/genesis.blob \
        --network $NETWORK \
        --path /opt/sui/db \
        --num-parallel-downloads 50 \
        --no-sign-request
    mv /opt/sui/db/epoch* /opt/sui/db/live
elif [ "$TYPE" == "rocksdb" ]; then
    /opt/sui/bin/sui-tool download-db-snapshot --latest \
        --network $NETWORK \
        --path /opt/sui/db \
        --num-parallel-downloads 50 \
        --skip-indexes \
        --no-sign-request
    mv /opt/sui/db/epoch* /opt/sui/db/live
fi

chown -R sui:sui /opt/sui
