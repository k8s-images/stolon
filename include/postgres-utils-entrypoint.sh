#!/usr/bin/env bash

set -eu

readonly argsCount=$#
readonly firstArg=${1:-}

if [ $argsCount -eq 0 ] || [ -z "$firstArg" ]; then
	exec bash
elif command -pv "$1" >/dev/null 2>/dev/null; then
	exec "$@"
else
	exec psql "$@"
fi
