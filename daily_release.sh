#!/bin/bash
set -e

# In order to build a different image name, set
# the environment variable IMAGE_NAME to what the
# name you want to create is.  This is also used
# as a parameter in the Jenkins job that calls this script.
# By default, this is jupyterlab.
IMAGE_NAME=${IMAGE_NAME:-'jupyterlab'}

# Use the format YYYYMMDD (for example 20180124)
# for the daily releases.  Pass it in on the command line,
# or by default, use today's date.
RELEASE_TAG=${1:-`date +%Y%m%d`}
echo "Creating daily release lsstepo/$IMAGE_NAME:d$RELEASE_TAG"

docker tag lsstepo/jupyterlab:dev lsstepo/$IMAGE_NAME:d$RELEASE_TAG
docker push lsstepo/$IMAGE_NAME:d$RELEASE_TAG
