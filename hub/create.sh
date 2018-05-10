#!/bin/bash
# Create a new kubernetes cluster and deploy a jupyterhub environment
set -ex

# Required commandline parameters
CLUSTER_NAME=$1
SSL_PRIVATE_KEY_FILE=$2
SSL_FULLCHAIN_FILE=$3

# Create the kubernetes cluster of the same name
./create_cluster.sh $CLUSTER_NAME

# Create the hub-config with the SSL cert and hostname
# The call to openssl generates the proxy secret token
python configure-hub.py $CLUSTER_NAME `openssl rand -hex 32` $SSL_PRIVATE_KEY_FILE $SSL_FULLCHAIN_FILE

# Create the hub deployment
./create_hub.sh

# Now we can get the public IP address of the cluster
CLUSTER_IP=`./get_ip.sh`

# Configure our DNS request
python configure-dns.py $CLUSTER_NAME $CLUSTER_IP

# Create a DNS record for the cluster to match the
# name and SSL certificate.
./create_dns.sh
