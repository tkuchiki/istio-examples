#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

rootdir="$(dirname ${0})/.."

cd ${rootdir}/common/go/delay-http-echo

set -eu

docker build -t delay-http-echo .
kind load docker-image delay-http-echo:latest --name ${CLUSTER_NAME}
