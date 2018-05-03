#!/bin/bash
# Destroy an existing environment and cluster.
set -x

CLUSTER_NAME=$1

# Delete the cluster
gcloud container clusters delete $CLUSTER_NAME \
    --zone us-central1-b \
    --quiet
