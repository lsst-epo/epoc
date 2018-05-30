# This script configures the hub-template.yaml with
# the proper values for a deploy.
import argparse
import os
import yaml

parser = argparse.ArgumentParser(description='Create hub-config.yaml')
parser.add_argument('hostname')
parser.add_argument('secretToken')
parser.add_argument('key')
parser.add_argument('cert')
args = parser.parse_args()

imageName = os.environ.get('IMAGE_NAME', 'lsstepo/jupyterlab')
releaseTag = os.environ.get('RELEASE_TAG', 'latest')

githubClientId = os.environ.get('GITHUB_OAUTH_CLIENT_ID', '')
githubClientSecret = os.environ.get('GITHUB_OAUTH_SECRET', '')

fqdn = args.hostname + '.lsst.rocks'

with open(args.key) as f:
  privKey = f.read()

with open(args.cert) as f:
  cert = f.read()

with open('hub-template.yaml') as f:
  configMap = yaml.safe_load(f)

authConfig = {
  'type': 'github',
  'github': {
    'clientId': githubClientId,
    'clientSecret': githubClientSecret,
    'callbackUrl': 'https://' + fqdn + '/hub/oauth_callback'
  }
}

proxyConfig = {
  'secretToken': args.secretToken,
  'https': {
    'type' : 'manual',
    'hosts': [fqdn],
    'manual' : {
      'key': privKey,
      'cert': cert
    }
  }
}

if githubClientId and githubClientSecret:
  configMap['auth'] = authConfig

configMap['proxy'] = proxyConfig
configMap['singleuser']['image']['name'] = imageName
configMap['singleuser']['image']['tag'] = releaseTag
configMap['singleuser']['extraEnv']['EXTERNAL_URL'] = 'https://' + fqdn

with open('hub-config.yaml', 'w') as f:
  f.write(yaml.dump(configMap))
