#!/bin/bash
# Create a DNS record for the cluster using the prepopulated
# dns-upsert.json file.
set -ex
aws route53 change-resource-record-sets --hosted-zone-id Z24VEHCIEZIICC --change-batch=file://dns-delete.json
