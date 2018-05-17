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

curl https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz
tar -xzvf /tmp/helm.tar.gz -C /tmp
mv /tmp/linux-amd64/helm /usr/local/bin

apt-get update
apt-get install -y google-cloud-sdk kubectl virtualenv docker-engine
apt-get clean
