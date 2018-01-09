#!/bin/bash
set -e

# This script runs inside the container to add all our special sauce.

# Install astropixie API library
sudo pip3 install /opt/astropixie

# Clone our educational notebooks
git clone https://github.com/lsst-epo/hr-diagram-investigations.git /opt/hr-diagram-activity
