FROM jenkins:2.32.3-alpine

ENV GOGS_BRANCH_SOURCE_VERSION=0.1-alpha

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

RUN curl -Lo /usr/share/jenkins/ref/plugins/gogs-branch-source-$GOGS_BRANCH_SOURCE_VERSION.hpi https://github.com/kmadel/gogs-branch-source-plugin/releases/download/v$GOGS_BRANCH_SOURCE_VERSION/gogs-branch-source-$GOGS_BRANCH_SOURCE_VERSION.hpi

# copy custom built plugins
COPY plugins/*.hpi /usr/share/jenkins/ref/plugins/

# so we can use jenkins cli
COPY config/jenkins.properties /usr/share/jenkins/ref/

# remove executors in master
COPY config/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# lets configure Jenkins with some defaults
COPY config/*.xml /usr/share/jenkins/ref/

# template replacement on the config.xml file
COPY replace-env-vars.sh /usr/bin/replace-env-vars.sh
COPY config/config.tmpl /usr/share/jenkins/templates/config.tmpl
COPY run-jenkins.sh /run-jenkins.sh

ENTRYPOINT ["/bin/tini", "-g", "--", "/run-jenkins.sh"]
