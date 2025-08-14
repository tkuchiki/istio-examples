#!/usr/bin/env bash

set -euo pipefail

source "$(dirname ${0})/inc.sh"

echo "Cleaning up Istio environment..."
echo "Cluster name: ${CLUSTER_NAME}"

if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "Deleting kind cluster: ${CLUSTER_NAME}"
    kind delete cluster --name "${CLUSTER_NAME}"
    echo "Cluster deleted successfully!"
else
    echo "Cluster ${CLUSTER_NAME} not found."
fi

echo "Cleanup completed!"
