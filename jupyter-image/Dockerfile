# EPO-406: We need to use the d20180111 image with jupyterlab where
# it will render javascript for the bokeh graphs.
#FROM lsstsqre/jld-lab:latest
FROM lsstepo/jupyterlab:d20180111

# Add our astropixie API library
ADD astropixie /opt/astropixie

# Add the hook that is called on jupyterlab startup to set the path
# to the notebooks.
ADD jupyter-image/refreshnb.sh /opt/lsst/software/jupyterlab/refreshnb.sh

# Add bake script, and call it.
ADD jupyter-image/bake.sh /opt/lsst-epo/bake.sh
RUN /opt/lsst-epo/bake.sh
