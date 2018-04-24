#!/bin/bash
set -e

docker run -p 8888:8888 -e DEBUG="true" -it --rm lsstepo/jupyterlab:dev /bin/bash -c 'source /etc/profile.d/local06-scl.sh && cd /opt/investigations && jupyter-lab --ip=''*'' --port=8888 --allow-root'
