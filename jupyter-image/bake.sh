#!/bin/bash
set -e

# This script runs inside the container to add all our special sauce.

# Install astropixie API library
pip3 install /opt/astropixie

# EPO-406 - We need to build on top of a previous EPO image
# If we're building on top of a previous image, delete those notebooks
# that may exist, so we can get a fresh copy without error.
rm -rf /opt/hr-diagram-activity

# Clone our educational notebooks
git clone https://github.com/lsst-epo/hr-diagram-investigations.git /opt/hr-diagram-activity

pip3 uninstall -y bokeh

git clone -b tickets/EPO-432 https://github.com/lsst-epo/bokeh.git
cd bokeh/bokehjs
npm install --no-save
node ./prepare.js
cd ..
python3 setup.py develop --build-js
chmod -R o+rw .

pip3 install git+https://github.com/jupyterhub/nbserverproxy
jupyter serverextension enable --py nbserverproxy
