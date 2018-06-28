#!/bin/bash
# Create a jupyterhub environment which is passed in
# as the parameter.
set -ex

# Get the jupyter charts
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

# Install jupyterhub charts
helm install jupyterhub/jupyterhub \
    --version=v0.7-e38c0a9 \
    --name=jupyterhub \
    --values=hub-config.yaml \
    --wait
