#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

${AWS_CMD} secretsmanager create-secret --name MySMSecret --secret-string 'My$uperS3cret' --no-cli-pager
# force a rotation
${AWS_CMD} secretsmanager update-secret --secret-id MySMSecret --secret-string 'My$uperS3cretV2' --no-cli-pager

${AWS_CMD} ssm put-parameter --name MySSMParam --value "SSMParamValue" --type String --no-cli-pager
