#!/usr/bin/env bash

export NODE_NAME=${NODE_NAME:-$(hostname --short)}
export DEFAULT_UID=${NODE_NAME//-/_}
export STKEEPER_UID=${STKEEPER_UID:-$DEFAULT_UID}
export STKEEPER_PG_LISTEN_ADDRESS=${POD_IP:-$(hostname --ip-address)}
export STKEEPER_PG_ADVERTISE_ADDRESS=${STKEEPER_PG_LISTEN_ADDRESS}

unset NODE_NAME DEFAULT_UID

echo "This keeper UID is $STKEEPER_UID"
echo
echo "Environment variables:"
echo
env | grep -v 'PASSWORD=' | grep '^ST' | sort
echo
echo "Data directory content:"
echo
ls -lA /data
echo

exec stolon-keeper "$@"
