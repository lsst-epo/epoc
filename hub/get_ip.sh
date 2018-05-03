#!/bin/bash
# Get the public proxy address of the deployed jupyterhub.
set -e

# Use JSONPath to get the IP address.
kubectl get svc proxy-public \
    --namespace=default \
    --output=jsonpath \
    --template='{.status.loadBalancer.ingress[0].ip}'

# Put the result on its own line.
echo ""
