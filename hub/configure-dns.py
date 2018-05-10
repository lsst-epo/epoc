# This script configures the hub-config.yaml with
# the proper values for a deploy.
import argparse
import json

parser = argparse.ArgumentParser(description='Configure DNS')
parser.add_argument('hostname')
parser.add_argument('ip')
args = parser.parse_args()

fqdn = args.hostname + '.lsst.rocks'

with open('dns-template.json') as f:
  dnsTemplate = json.load(f)

dnsTemplate['Changes'][0]['ResourceRecordSet']['Name'] = fqdn
dnsTemplate['Changes'][0]['ResourceRecordSet']['ResourceRecords'][0]['Value'] = args.ip

dnsTemplate['Changes'][0]['Action'] = 'UPSERT'
with open('dns-upsert.json', 'w') as f:
  json.dump(dnsTemplate, f)

dnsTemplate['Changes'][0]['Action'] = 'DELETE'
with open('dns-delete.json', 'w') as f:
  json.dump(dnsTemplate, f)
