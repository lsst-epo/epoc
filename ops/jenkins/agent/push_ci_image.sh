#!/bin/bash
set -e

RELEASE_TAG=${1:-`date +%Y%m%d`}
echo "Creating jenkins ci agent image lsstepo/jenkins-agent:$RELEASE_TAG"

docker tag lsstepo/jenkins-agent:dev lsstepo/jenkins-agent:$RELEASE_TAG
docker tag lsstepo/jenkins-agent:$RELEASE_TAG lsstepo/jenkins-agent:latest

docker push lsstepo/jenkins-agent:$RELEASE_TAG
docker push lsstepo/jenkins-agent:latest
