#!/bin/bash
set -e

kubectl delete ingress jenkins-ingress
helm delete --purge jenkins
