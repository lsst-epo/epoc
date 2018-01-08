#!/bin/bash
set -e

docker build -t lsstepo/jupyterlab:dev -f ./jupyter-image/Dockerfile .
