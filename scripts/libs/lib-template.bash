#!/usr/bin/env bash
set -e
set -o pipefail
[[ "${KREDUL_DEBUG}" = "true" ]] && set -x || set +x

my_func () {
	echo "my func"
}
