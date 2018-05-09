# This script configures the hub-template.yaml with
# the proper values for a deploy.
import argparse
import yaml

parser = argparse.ArgumentParser(description='Create hub-config.yaml')
parser.add_argument('host')
parser.add_argument('secretToken')
parser.add_argument('key')
parser.add_argument('cert')
args = parser.parse_args()

with open(args.key) as f:
  privKey = f.read()

with open(args.cert) as f:
  cert = f.read()

with open('hub-template.yaml') as f:
  configMap = yaml.safe_load(f)

proxyConfig = {
  'secretToken': args.secretToken,
  'https': {
    'type' : 'manual',
    'hosts': [args.host],
    'manual' : {
      'key': privKey,
      'cert': cert
    }
  }
}

configMap['proxy'] = proxyConfig

with open('hub-config.yaml', 'w') as f:
  f.write(yaml.dump(configMap))
