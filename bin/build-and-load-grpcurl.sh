#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

rootdir="$(dirname ${0})/.."

cd ${rootdir}/common/grpc

docker build -t mygrpcurl .
kind load docker-image mygrpcurl:latest --name ${CLUSTER_NAME}
