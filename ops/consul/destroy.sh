#!/bin/bash
# Destroy the consul helm deployment.
# Note: This does not destroy the persistent volumes the data
# is stored over.  You do not want to delete this data, as vault
# is stored on it.
#
# In case you need to destroy the consul volumes, run this:
#
# kubectl delete pvc -l component=consul-consul
set -e

helm delete --purge consul
