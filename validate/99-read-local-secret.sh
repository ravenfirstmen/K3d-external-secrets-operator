#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

${KUBECTL_CMD} get secret aws-secret -n external-secrets -o jsonpath='{.data.current-value}' | base64 --decode
${KUBECTL_CMD} get secret aws-secret -n external-secrets -o jsonpath='{.data.previous-value}' | base64 --decode
${KUBECTL_CMD} get secret aws-ssm-param -n external-secrets -o jsonpath='{.data.the-value}' | base64 --decode
