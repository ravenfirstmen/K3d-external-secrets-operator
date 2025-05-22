# K3d External Secrets Operator

This project provides a setup for running [External Secrets Operator](https://external-secrets.io/) on a [k3d](https://k3d.io/) Kubernetes cluster. It enables secure synchronization of secrets from external secret management systems (like AWS Secrets Manager, HashiCorp Vault, etc.) into Kubernetes.

## Features

- Local Kubernetes cluster using k3d
- Automated deployment of External Secrets Operator
- Example configuration for syncing secrets unsing [localstack](https://www.localstack.cloud/)
- Use of stakater for pod restart on secrets changes

## Prerequisites

- [Docker](https://www.docker.com/)
- [k3d](https://k3d.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/)

## Getting Started

1. **Create a k3d cluster:**
    ```sh
    ./start-cluster.sh
    ```

2. **Test a sample:**
    ```sh
    cd validate
    ./00-create-aws-secrets.sh           
    ./01-config-secrets-stores.sh
    ./02-config-external-secret.sh      
    ./03-deploy-netshoot.sh  
    # open a shell inside netshoot and read the value of /mnt/param-secret/thhe-value
    
    # update the value
    ./04-update-aws-secrets.sh
    # the pod should be restarted
    # open a shell inside netshoot and read the value of /mnt/param-secret/thhe-value

    ```
3. **Shutdown k3d cluster:**
    ```sh
    ./stop-cluster.sh
    ```


## Resources

- [External Secrets Operator Documentation](https://external-secrets.io/)
- [k3d Documentation](https://k3d.io/)

## License

This project is licensed under the MIT License.