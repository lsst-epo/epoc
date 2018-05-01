#!/bin/bash
# This script runs inside the container to add all our special sauce.
set -ex

# Install healpy and astroquery
pip install healpy astroquery==0.3.7

# Install ipyaladin
git clone https://github.com/cds-astro/ipyaladin.git /opt/ipyaladin
(cd /opt/ipyaladin/js && npm install --unsafe-perm)
(cd /opt/ipyaladin && pip install -e .)
(cd /opt/ipyaladin/js && jupyter labextension install --no-build)

# Install bokeh
pip install bokeh
jupyter labextension install jupyterlab_bokeh --no-build

# Install nbserverproxy.  This allows for URLs like /user/x/proxy/d
# to be routed to port d on the container.
pip install git+https://github.com/jupyterhub/nbserverproxy
jupyter serverextension enable --py nbserverproxy

# Install jupyter extensions.
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build

# Install astropixie API library
pip install /opt/astropixie
pip install /opt/astropixie-widgets

# Install our own EPO extensions.
jupyter labextension install jupyterlab_hidecode --no-build

# Final build
jupyter lab clean
jupyter lab build

# Clone our educational notebooks
git clone https://github.com/lsst-epo/investigations.git /opt/investigations
