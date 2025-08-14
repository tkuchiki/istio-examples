#!/bin/bash

set -euo pipefail

source "$(dirname ${0})/inc.sh"
KINDCONFIG_FILE="$(dirname "$0")/kind-config.yaml"

echo "Creating kind cluster: ${CLUSTER_NAME}"

if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "Cluster ${CLUSTER_NAME} already exists."
    echo "Delete it with: kind delete cluster --name ${CLUSTER_NAME}"
    exit 1
fi

if [ ! -f "${KINDCONFIG_FILE}" ]; then
    echo "Creating kind configuration file..."
    cat > "${KINDCONFIG_FILE}" <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
  - containerPort: 15021
    hostPort: 15021
    protocol: TCP
EOF
fi

kind create cluster --name "${CLUSTER_NAME}" --config "${KINDCONFIG_FILE}"

echo "Waiting for cluster to be ready..."
kubectl cluster-info --context "kind-${CLUSTER_NAME}"

echo "Kind cluster '${CLUSTER_NAME}' created successfully!"
echo "To delete the cluster, run: kind delete cluster --name ${CLUSTER_NAME}"
