#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

kubectl apply -f istio-${ISTIO_VERSION}/samples/httpbin/httpbin.yaml
