#!/bin/bash
# Destroy an existing environment and cluster.
set -x

# Delete the jupyterhub deployment
helm delete jupyterhub --purge
