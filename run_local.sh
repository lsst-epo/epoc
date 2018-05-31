#!/bin/bash
set -e

docker run -p 8888:8888 -e DEBUG="true" -e EXTERNAL_URL="http://localhost:8888" -e JUPYTERHUB_SERVICE_PREFIX="" -it --rm lsstepo/jupyterlab:dev /bin/bash -c 'cd /opt/investigations && jupyter-lab --ip=''*'' --port=8888 --allow-root'
