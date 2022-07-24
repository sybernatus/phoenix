#!/usr/bin/env bash
set -e
set -o pipefail
[[ "${KREDUL_DEBUG}" = "true" ]] && set -x || set +x

kind_get_cluster_name () {
  echo -n "phoenix-local"
}

kind_get_registry_name () {
  echo -n "kind-registry"
}

kind_get_cluster_port () {
  echo -n "35555"
}
