#FROM lsstsqre/jld-lab:latest
FROM lsstepo/python36-lab

# Add our astropixie API library
ADD astropixie /opt/astropixie

# Add the hook that is called on jupyterlab startup to set the path
# to the notebooks.
ADD jupyter-image/runlab.sh jupyter-image/lablauncher.bash jupyter-image/refreshnb.sh /opt/lsst/software/jupyterlab/

# Add bake script, and call it.
ADD jupyter-image/bake.sh /opt/lsst-epo/bake.sh
RUN /opt/lsst-epo/bake.sh
