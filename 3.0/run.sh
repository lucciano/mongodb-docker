#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

if [ "$REPLICA_SET" != ""]; then
    cmd="$cmd --replSet $REPLICA_SET"
fi

if [ "$SHARD" != "yes"]; then
    cmd="$cmd --shardsvr"
fi

if [ "$CFGSRV" != "yes"]; then
    cmd="$cmd --configsvr"
fi



$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

fg
