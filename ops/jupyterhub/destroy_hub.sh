#!/bin/bash
# Destroy an existing environment and cluster.
set -x

# Delete the jupyterhub deployment
helm delete jupyterhub --purge

# Delete leftover daemonsets for the prepuller which aren't
# cleaned up by helm.
kubectl delete daemonset --all
