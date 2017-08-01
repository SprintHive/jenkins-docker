FROM jenkins/jenkins:lts-alpine

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# copy custom built plugins
COPY plugins/*.hpi /usr/share/jenkins/ref/plugins/

# so we can use jenkins cli
COPY config/jenkins.properties /usr/share/jenkins/ref/

# remove executors in master
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# lets configure Jenkins with some defaults
COPY config/*.xml /usr/share/jenkins/ref/

# add config templates and script to resolve them into concrete configs
COPY config/templates/*.tmpl /usr/share/jenkins/templates/
COPY replace-env-vars.sh /usr/bin/replace-env-vars.sh

COPY run-jenkins.sh /run-jenkins.sh

ENTRYPOINT ["/bin/tini", "-g", "--", "/run-jenkins.sh"]
