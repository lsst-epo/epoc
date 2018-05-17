#!/bin/bash
set -e

docker run -p 8888:8888 -e DEBUG="true" -it --rm lsstepo/jupyterlab:dev /bin/bash -c 'cd /opt/investigations && jupyter-lab --ip=''*'' --port=8888 --allow-root'
