#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

cat <<'EOT' | ${KUBECTL_CMD} apply -f -
---
apiVersion: generators.external-secrets.io/v1alpha1
kind: Password
metadata:
  name: platform-api-key
  namespace: external-secrets
spec:
  length: 50
  digits: 5
  symbols: 5
  symbolCharacters: "-_$@"
  noUpper: false
  allowRepeat: true
---
apiVersion: external-secrets.io/v1alpha1
kind: PushSecret
metadata:
  name: push-plat-key-to-aws
  namespace: external-secrets
spec:
  updatePolicy: Replace
  refreshInterval: 1h
  # refreshInterval: 10s
  secretStoreRefs:
    - name: aws-parameter-store
      kind: SecretStore
  selector:
    generatorRef:
      apiVersion: generators.external-secrets.io/v1alpha1
      kind: Password
      name: platform-api-key
  data:
    - match:
        secretKey: password
        remoteRef:
          remoteKey: /platform/api/key
EOT
