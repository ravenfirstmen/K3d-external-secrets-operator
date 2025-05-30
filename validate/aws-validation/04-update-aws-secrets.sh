#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

${AWS_CMD} secretsmanager update-secret --secret-id MySMSecret --secret-string 'My$uperS3cretV3' --no-cli-pager
${AWS_CMD} ssm put-parameter --name MySSMParam --value "MyOtherSSMParamValue" --type String --overwrite --no-cli-pager