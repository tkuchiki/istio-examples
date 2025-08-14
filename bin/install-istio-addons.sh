#!/usr/bin/env bash

set -eo pipefail

source "$(dirname ${0})/inc.sh"

ISTIO_RELEASE_VERSION="$(echo ${ISTIO_VERSION} | awk -F '.' '{print $1 "." $2}')"

echo "Installing Istio addons..."
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_RELEASE_VERSION}/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_RELEASE_VERSION}/samples/addons/grafana.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_RELEASE_VERSION}/samples/addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${ISTIO_RELEASE_VERSION}/samples/addons/kiali.yaml
