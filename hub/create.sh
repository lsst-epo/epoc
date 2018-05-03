#!/bin/bash
# Create a new kubernetes cluster and deploy a jupyterhub environment
set -ex

CLUSTER_NAME=$1

./create_cluster.sh $CLUSTER_NAME
./create_hub.sh
