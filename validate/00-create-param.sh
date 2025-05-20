#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

${AWS_CMD} ssm put-parameter --name MySSMParam --value "SSMParamValue" --type String --no-cli-pager
