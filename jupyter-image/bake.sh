#!/bin/bash
# This script runs inside the container to add all our special sauce.
set -ex

# Add a file that stores the creation time, just in case.
echo Created on `date +%Y-%m-%d` > /opt/create_date

# Install healpy and astroquery
pip install healpy astroquery==0.3.8

# Install ipyaladin
git clone https://github.com/lsst-epo/ipyaladin.git /opt/ipyaladin
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
pip install -e /opt/astropixie
pip install -e /opt/astropixie-widgets

# Install our own EPO extensions.
git clone https://github.com/lsst-epo/jupyterlab_celltools.git /opt/jupyterlab_celltools
(cd /opt/jupyterlab_celltools && npm install && npm run build)
jupyter labextension link /opt/jupyterlab_celltools

# Install our own EPO theme.
git clone https://github.com/lsst-epo/jupyterlab_epotheme.git /opt/jupyterlab_epotheme
(cd /opt/jupyterlab_epotheme && npm install && npm run build)
jupyter labextension link /opt/jupyterlab_epotheme

# Final build
jupyter lab clean
jupyter lab build

# Clone our educational notebooks
git clone https://github.com/lsst-epo/investigations.git /opt/investigations
cp -r /opt/investigations ~jovyan/investigations
chown -R jovyan ~jovyan/investigations ~jovyan/.jupyter
