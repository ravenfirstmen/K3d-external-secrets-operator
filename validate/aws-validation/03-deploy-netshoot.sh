#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

${KUBECTL_CMD} apply -f 03-deploy-netshoot.yaml
