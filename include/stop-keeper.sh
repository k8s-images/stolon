#!/usr/bin/env bash
# shellcheck disable=SC2155

readonly processId=$(pidof stolon-keeper 2>/dev/null | tr -d '\n ')
readonly keeperId=$(jq -r .UID /data/keeperstate 2>/dev/null | tr -d '\n ')
declare -i isHealthy=0

getIsHealthy() {
	local healthy pgHealthy
	[ -n "$keeperId" ] || return 1

	keeperInfo=$(stolonctl status | jq -r '.keepers[] 2>/dev/null | select(.uid == "'"$keeperId"'")' | tr -d '\n ')
	healthy=$(echo "$keeperInfo" | jq -r '.healthy' | tr -d '\n ')
	pgHealthy=$(echo "$keeperInfo" | jq -r '.pg_healthy' | tr -d '\n ')

	if [ "$healthy" = "true" ] && [ "$pgHealthy" = "true" ]; then
		isHealthy=1
	else
		isHealthy=0
	fi
}

main() {
	if [ -z "$processId" ] || [ -z "$keeperId" ]; then
		exit 1
	fi

	stolonctl failkeeper "$keeperId"

	while [ $isHealthy -eq 1 ]; do
		getIsHealthy
		sleep 1
	done

	kill "$processId"
}

main
