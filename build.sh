#!/bin/bash
set -e

# Build the image.
# Note: the working directory is the base of the repo.  Also check
# the .dockerignore to whitelist files to be included in the image. 
docker build --pull -t lsstepo/jupyterlab:dev -f ./jupyter-image/Dockerfile .
