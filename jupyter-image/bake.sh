#!/bin/bash
set -e

# This script runs inside the container to add all our special sauce.

# Install astropixie API library
pip3 install /opt/astropixie

# Install ipyaladin
git clone https://github.com/cds-astro/ipyaladin.git /opt/ipyaladin
(cd /opt/ipyaladin/js && npm install --unsafe-perm)
(cd /opt/ipyaladin && pip install -e .)
(cd /opt/ipyaladin/js && jupyter labextension install)

# Clone our educational notebooks
git clone https://github.com/lsst-epo/hr-diagram-investigations.git /opt/hr-diagram-activity

pip3 uninstall -y bokeh

git clone -b tickets/EPO-432 https://github.com/lsst-epo/bokeh.git
cd bokeh/bokehjs
npm install --no-save
node ./prepare.js
cd ..
python3 setup.py develop --build-js

# Install nbserverproxy.  This allows for URLs like /user/x/proxy/d
# to be routed to port d on the container.
pip3 install git+https://github.com/jupyterhub/nbserverproxy
jupyter serverextension enable --py nbserverproxy
