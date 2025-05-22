#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

${AWS_CMD} secretsmanager get-secret-value --secret-id MySMSecret --no-cli-pager
${AWS_CMD} ssm get-parameter --name MySSMParam --no-cli-pager