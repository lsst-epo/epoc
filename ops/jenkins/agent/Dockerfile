FROM jenkins/jnlp-slave

USER root
ADD bake_ci_image.sh /tmp
RUN /tmp/bake_ci_image.sh

USER jenkins
