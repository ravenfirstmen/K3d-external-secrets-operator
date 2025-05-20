#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

cat <<EOT | ${KUBECTL_CMD} apply -f -
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: parameterstore
  namespace: external-secrets
spec:
  refreshInterval: 1m
  secretStoreRef:
    name: parameterstore
    kind: SecretStore
  target:
    name: ssm-aws-param
  data:
  - secretKey: the-value
    remoteRef:
      key: MySSMParam
EOT