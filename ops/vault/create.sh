#!/bin/bash
set -e

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install --name vault -f vault.yaml incubator/vault
