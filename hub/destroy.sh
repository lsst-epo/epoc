#!/bin/bash
# Destroy an existing environment and cluster.
set -x

CLUSTER_NAME=$1

./destroy_hub.sh
./destroy_cluster.sh $CLUSTER_NAME
