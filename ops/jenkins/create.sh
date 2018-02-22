#!/bin/bash
set -e

helm install -f jenkins.yaml --name jenkins stable/jenkins
kubectl create -f ingress.yaml
