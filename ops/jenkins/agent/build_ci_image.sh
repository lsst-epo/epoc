#!/bin/bash
set -e

sudo docker build --no-cache -t lsstepo/jenkins-agent:dev .
