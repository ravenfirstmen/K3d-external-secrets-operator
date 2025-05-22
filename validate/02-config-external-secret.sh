#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

cat <<EOT | ${KUBECTL_CMD} apply -f -
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: parameter-store
  namespace: external-secrets
spec:
  refreshInterval: 1m
  secretStoreRef:
    name: parameter-store
    kind: SecretStore
  target:
    name: aws-ssm-param
  data:
  - secretKey: the-value
    remoteRef:
      key: MySSMParam
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: secrets-manager
  namespace: external-secrets
spec:
  refreshInterval: 1m
  secretStoreRef:
    name: secrets-manager
    kind: SecretStore
  target:
    name: aws-secret
  data:
  - secretKey: current-value
    remoteRef:
      key: MySMSecret
      version: AWSCURRENT
  - secretKey: previous-value
    remoteRef:
      key: MySMSecret
      version: AWSPREVIOUS
EOT