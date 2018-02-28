#!/bin/bash
set -e

helm install -f nginx.yaml --name nginx stable/nginx-ingress
