#!/usr/bin/env bash

source "$(dirname ${0})/inc.sh"

kubectl apply -f common/go/delay-http-echo/delay-http-echo.yaml
