#!/bin/bash
set -e

# Note: if you don't pull the latest image, docker build won't check
# if there's a newer one.
docker pull lsstsqre/jld-lab:latest

# Build the image.
# Note: the working directory is the base of the repo.  Also check
# the .dockerignore to whitelist files to be included in the image. 
docker build -t lsstepo/jupyterlab:dev -f ./jupyter-image/Dockerfile .
