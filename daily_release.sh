#!/bin/bash
set -e

RELEASE_TAG=`date +%Y%m%d`
echo "Creating daily release $RELEASE_TAG"

docker tag lsstepo/jupyterlab:dev lsstepo/jupyterlab:d$RELEASE_TAG
docker push lsstepo/jupyterlab:d$RELEASE_TAG
