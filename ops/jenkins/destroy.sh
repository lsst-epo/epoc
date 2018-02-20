#!/bin/bash
kubectl delete ingress jenkins-ingress
helm delete --purge jenkins
