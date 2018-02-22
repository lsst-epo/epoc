#!/bin/bash
set -e

# Install the ability to get packages over https first,
# since docker-engine needs this to install.
apt-get update
apt-get install -y apt-transport-https

echo "deb https://apt.dockerproject.org/repo debian-stretch main" | tee -a /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb http://packages.cloud.google.com/apt cloud-sdk-stretch main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt-get update
apt-get install -y google-cloud-sdk kubectl virtualenv docker-engine
apt-get clean
