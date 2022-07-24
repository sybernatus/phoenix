#!/usr/bin/env bash
set -e
set -o pipefail
[[ "${PHOENIX_DEBUG}" = "true" ]] && set -x || set +x

workspaceDirectory="$( git rev-parse --show-toplevel )"

tree_get_kind_config_path () {
    echo -n "tools/kind/cluster/kind-cluster-definition.yaml"
}
