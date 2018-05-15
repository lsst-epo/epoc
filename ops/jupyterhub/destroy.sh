#!/bin/bash
# Destroy an existing environment and cluster.
set -x

CLUSTER_NAME=$1

./destroy_dns.sh
./destroy_hub.sh
./destroy_cluster.sh $CLUSTER_NAME
exit 0
