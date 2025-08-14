#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

kubectl exec deploy/curl -- curl "${@}"
