#!/bin/bash
set -e

DAILY_RELEASE=${1?Did not provide daily release to promote}
RELEASE_TAG=${2?Did not provide release to create}

echo "Creating release $RELEASE_TAG from daily release $DAILY_RELEASE"

docker tag lsstepo/jupyterlab:d$DAILY_RELEASE lsstepo/jupyterlab:r$RELEASE_TAG
docker push lsstepo/jupyterlab:r$RELEASE_TAG
