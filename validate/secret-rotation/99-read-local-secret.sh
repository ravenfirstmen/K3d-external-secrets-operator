#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

${KUBECTL_CMD} get secret platform-key-runtime-stamp -n external-secrets  -o yaml | yq -r '.data.key' | base64 -d && echo
${KUBECTL_CMD} get secret platform-key-id-stamp -n external-secrets -o yaml  | yq -r '.data.key' | base64 -d && echo
