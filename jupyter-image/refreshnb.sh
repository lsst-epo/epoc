#!/bin/bash
set -e

# Delete any previous user notebooks.
rm -rf ~/notebooks

# Make a copy of the notebooks.  This is better than a symlink
# because the user will be able to modify and save in their own
# home directory.
cp -R /opt/hr-diagram-activity ~/notebooks
