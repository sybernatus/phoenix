#!/usr/bin/env bash

##### HEADER
set -e
set -o pipefail
[[ "${KREDUL_DEBUG}" = "true" ]] && set -x || set +x

hereDir=$( cd $(dirname "${0}") && pwd)
workspaceDirectory="$( git rev-parse --show-toplevel )"

source "${workspaceDirectory}/scripts/libs/lib-log.bash"
source "${workspaceDirectory}/scripts/libs/lib-exit.bash"
source "${workspaceDirectory}/scripts/libs/lib-kind.bash"
source "${workspaceDirectory}/scripts/libs/lib-tree.bash"
##### HEADER

log_start_script "${hereDir} - K3D cluster complete removal & installation"

clusterName="$( "kind_get_cluster_name" )"
registryName="$( "kind_get_registry_name" )"
registryPort="$( "kind_get_cluster_port" )"

clean_install_registry () {
  if [ "$(docker inspect -f '{{.State.Running}}' "${registryName}" 2>/dev/null || true)" != 'true' ]; then
    docker run \
      -d --restart=always -p "127.0.0.1:${registryPort}:5000" --name "${registryName}" \
      registry:2
  fi
}

help()
{
   # Display Help
   echo "Remove and install the cluster, build containerized application and install it in the cluster."
   echo "Optional: remove & install the registry"
   echo
   echo "Syntax: scriptTemplate [-h|r]"
   echo "options:"
   echo "-r | --registry      Clean up existing registry."
   echo "-h | --help          Print this Help."
   echo
}

#options
if [[ $# -gt 0 ]] ; then
  while true; do
    case $1 in
      --help | -h)
        help
        exit 0
        ;;
      --registry | -r)
        "clean_install_registry" "${registryName}" "${registryPort}"
        shift
        break
        ;;
      "" )
        shift
        break
        ;;
      *)
        shift
        break
    esac
  done
fi

log_write_section "Remove cluster - ${clusterName}"
"kind" delete cluster --name "${clusterName}"

log_write_section "Create cluster - ${clusterName}"
clusterConfig=$( "tree_get_kind_config_path" )
"kind" create cluster --name "${clusterName}" --config  "${clusterConfig}"

log_write_section "Deploy Ingress controller"
"kubectl" apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
