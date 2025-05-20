#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/../_local_vars.sh

${AWS_CMD} ssm get-parameter --name MySSMParam --no-cli-pager