#!/usr/bin/env bash
set -e
set -o pipefail
[[ "${KREDUL_DEBUG}" = "true" ]] && set -x || set +x

hereDir=$( cd $(dirname "${0}") && pwd)
workspaceDirectory="$( git rev-parse --show-toplevel )"

source "${workspaceDirectory}/scripts/libs/lib-log.bash"

exit_on_error () {
  RETURN_CODE=${?}
  if [ "${RETURN_CODE}" != 0 ]; then
    echo "An error occurred. exit ${RETURN_CODE}"
    exit "${RETURN_CODE}"
  fi
}

exit_nothing_to_do () {
  TEST_VAR=$(echo "${1}" | tr -d " ")
  if [[ -z "$TEST_VAR" ]]
  then
    log_info "Nothing to do. Exiting."
    exit 0
  fi
}
