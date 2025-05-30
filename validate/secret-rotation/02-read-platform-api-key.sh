#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../../_local_vars.sh

${AWS_CMD} ssm get-parameter --name "/platform/api/key" --no-cli-pager
${AWS_CMD} ssm get-parameter --name "/platform/api/key" --no-cli-pager | jq -r '.Parameter.Value'
# ${AWS_CMD} ssm get-parameters-by-path --path "/platform/api" --no-cli-pager 

