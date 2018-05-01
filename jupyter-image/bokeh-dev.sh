#!/bin/bash
set -e

# Gulp in bokeh requires a ridiculously recent NodeJS
curl -o /opt/node.xz https://nodejs.org/dist/v8.10.0/node-v8.10.0-linux-x64.tar.xz
(cd /opt && tar xvfJ node.xz)
export PATH=/opt/node-v8.10.0-linux-x64/bin:$PATH

rm -rf /tmp/phantomjs

git clone https://github.com/bokeh/bokeh.git
cd bokeh/bokehjs
npm install --no-save --unsafe-perm
node ./prepare.js
cd ..
python setup.py develop --build-js
