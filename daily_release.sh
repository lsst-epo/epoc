#!/bin/bash
set -e

# Use the format YYYYMMDD (for example 20180124)
# for the daily releases.  Pass it in on the command line,
# or by default, use today's date.
RELEASE_TAG=${1:-`date +%Y%m%d`}
echo "Creating daily release $RELEASE_TAG"

docker tag lsstepo/jupyterlab:dev lsstepo/jupyterlab:d$RELEASE_TAG
docker push lsstepo/jupyterlab:d$RELEASE_TAG
