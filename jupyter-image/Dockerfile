FROM jupyter/minimal-notebook:e7000ca1416d

# Add our astropixie API library
ADD astropixie /opt/astropixie
ADD astropixie-widgets /opt/astropixie-widgets

# Add our scripts
ADD jupyter-image/*.sh /opt/lsst-epo/

# Call our bake script
USER root
RUN /opt/lsst-epo/bake.sh
