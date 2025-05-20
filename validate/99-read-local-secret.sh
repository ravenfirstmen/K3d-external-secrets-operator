#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

${KUBECTL_CMD} get secret ssm-aws-param -n external-secrets -o jsonpath='{.data.the-value}' | base64 --decode