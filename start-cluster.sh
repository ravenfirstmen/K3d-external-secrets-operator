#!/usr/bin/env bash

source "$(dirname "$(readlink -f "$0")")"/_local_vars.sh

mkdir -p "${DOT_K3D_MANIFESTS_FOLDER}"
mkdir -p "${DOT_K3D_VOLUMES_FOLDER}"

cp ${MANIFESTS_FOLDER}/* "${DOT_K3D_MANIFESTS_FOLDER}"

uuidgen | tr -d '-' > ${DOT_K3D_VOLUMES_FOLDER}/machine-id

# reference/source: https://hub.docker.com/r/rancher/k3s/tags
CPUARCH=$(uname -m)
if [[ "$CPUARCH" == "arm64" ]]; then
    IMAGE=rancher/k3s:v1.30.11-k3s1-arm64
else
    IMAGE=rancher/k3s:v1.30.11-k3s1-amd64
fi

export K3D_FIX_MOUNTS=1
export K3D_FIX_DNS=1

if k3d cluster list "${CLUSTER_NAME}" > /dev/null 2>&1; then
    echo "Refreshing cluster...."
	k3d cluster delete "${CLUSTER_NAME}"
fi

k3d cluster create "${CLUSTER_NAME}" \
    --image "${IMAGE}" \
    --api-port "localhost:6443" \
    --registry-create "${REGISTRY}" \
    --port "80:80@loadbalancer" \
    --port "9090:9090@loadbalancer" \
    --port "3000:3000@loadbalancer" \
    --port "3100:3100@loadbalancer" \
    --port "4566:4566@loadbalancer" \
    --servers 3 \
    --agents 1 \
    --wait \
    --k3s-arg '--disable=metrics-server@server:*' \
    --volume "${DOT_K3D_MANIFESTS_FOLDER}:/var/lib/rancher/k3s/server/manifests/custom@server:*" \
    --volume "${DOT_K3D_VOLUMES_FOLDER}/machine-id:/etc/machine-id@server:*;agent:*" \
    --k3s-node-label 'cluster/nodegroup=infra@server:*' \
    --k3s-node-label 'cluster/nodegroup=jobs@agent:*'

# kubectl rollout status deployment localstack -n localstack --timeout=240s > /dev/null 2>&1
