#!/bin/bash
# Create a jupyterhub environment which is passed in
# as the parameter.
set -ex

CLUSTER_NAME=$1
NUM_NODES=${NUM_NODES:-'2'}
NODE_TYPE=${NODE_TYPE:-'n1-standard-2'}

# Create a cluster
gcloud container clusters create $CLUSTER_NAME \
    --num-nodes=$NUM_NODES \
    --machine-type=$NODE_TYPE \
    --zone=us-central1-b

# Set up tiller
kubectl create serviceaccount tiller \
    --namespace=kube-system

kubectl create clusterrolebinding tiller \
    --clusterrole cluster-admin \
    --serviceaccount=kube-system:tiller

helm init --wait --service-account tiller

kubectl patch deployment tiller-deploy \
    --namespace=kube-system \
    --type=json \
    --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'
