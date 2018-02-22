FROM jenkins/jnlp-slave

USER root
ADD env_to_file /usr/local/bin
ADD bake_ci_image.sh /tmp
RUN /tmp/bake_ci_image.sh

USER jenkins
