#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

kubectl apply -f common/grpc/grpcurl.yaml
