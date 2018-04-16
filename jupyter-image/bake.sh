#!/bin/bash
set -e

# This script runs inside the container to add all our special sauce.

# Install astropixie API library
pip3 install /opt/astropixie
pip3 install /opt/astropixie-widgets

# Install healpy and astroquery
pip3 install healpy astroquery==0.3.7

# Install ipyaladin
git clone https://github.com/cds-astro/ipyaladin.git /opt/ipyaladin
(cd /opt/ipyaladin/js && npm install --unsafe-perm)
(cd /opt/ipyaladin && pip install -e .)
(cd /opt/ipyaladin/js && jupyter labextension install)

# Clone our educational notebooks
git clone https://github.com/lsst-epo/investigations.git /opt/investigations

# Gulp in bokeh requires a ridiculously recent NodeJS
curl -o /opt/node.xz https://nodejs.org/dist/v8.10.0/node-v8.10.0-linux-x64.tar.xz
(cd /opt && tar xvfJ node.xz)
export PATH=/opt/node-v8.10.0-linux-x64/bin:$PATH

rm -rf /tmp/phantomjs
pip3 uninstall -y bokeh

git clone https://github.com/bokeh/bokeh.git
cd bokeh/bokehjs
npm install --no-save --unsafe-perm
node ./prepare.js
cd ..
python3 setup.py develop --build-js

# Install nbserverproxy.  This allows for URLs like /user/x/proxy/d
# to be routed to port d on the container.
pip3 install git+https://github.com/jupyterhub/nbserverproxy
jupyter serverextension enable --py nbserverproxy

jupyter labextension install jupyterlab_hidecode
