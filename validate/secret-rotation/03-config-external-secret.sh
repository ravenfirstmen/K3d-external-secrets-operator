#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

cat <<EOT | ${KUBECTL_CMD} apply -f -
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: platform-key-id-stamp
  namespace: external-secrets
spec:
  # refreshInterval: 1m
  refreshInterval: 10s
  secretStoreRef:
    name: aws-parameter-store
    kind: SecretStore
  target:
    name: platform-key-id-stamp
  data:
  - secretKey: key
    remoteRef:
      key: /platform/api/key
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: platform-key-runtime-stamp
  namespace: external-secrets
spec:
  # refreshInterval: 1m
  refreshInterval: 10s
  secretStoreRef:
    name: aws-parameter-store
    kind: SecretStore
  target:
    name: platform-key-runtime-stamp
  data:
  - secretKey: key
    remoteRef:
      key: /platform/api/key
EOT