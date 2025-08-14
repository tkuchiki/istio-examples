#!/usr/bin/env bash

set -eo pipefail

source "$(dirname ${0})/inc.sh"

if [ "${1}" != "" ]; then
    ISTIO_VERSION="${1}"
fi

set -u

echo "Downloading Istio version: ${ISTIO_VERSION}"

ISTIO_VERSION=${ISTIO_VERSION} sh ${DOWNLOAD_SCRIPT}

kubectl config use-context "${CLUSTER_CONTEXT}"

echo "Installing Istio with demo profile..."
istioctl install --set values.defaultRevision=default --skip-confirmation

echo "Enabling Istio injection for default namespace..."
kubectl label namespace default istio-injection=enabled --overwrite

echo "Waiting for Istio components to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/istiod -n istio-system

