#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

cat <<'EOT' | ${KUBECTL_CMD} apply -f -
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: parameter-store
  namespace: external-secrets
spec:
  provider:
    aws:
      service: ParameterStore
      region: us-east-1
      auth:
        secretRef:
          accessKeyIDSecretRef:
            name: awssm-secret
            namespace: external-secrets
            key: AWS_ACCESS_KEY_ID
          secretAccessKeySecretRef:
            name: awssm-secret
            namespace: external-secrets
            key: AWS_SECRET_ACCESS_KEY  
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: secrets-manager
  namespace: external-secrets
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        secretRef:
          accessKeyIDSecretRef:
            name: awssm-secret
            namespace: external-secrets
            key: AWS_ACCESS_KEY_ID
          secretAccessKeySecretRef:
            name: awssm-secret
            namespace: external-secrets
            key: AWS_SECRET_ACCESS_KEY  
EOT