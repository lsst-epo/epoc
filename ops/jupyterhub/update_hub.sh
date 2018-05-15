#!/bin/bash
# Update the hub with changes to hub-config.yaml
set -ex

helm upgrade jupyterhub jupyterhub/jupyterhub \
    --version=v0.6 \
    --values=hub-config.yaml
