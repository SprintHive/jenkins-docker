#/bin/bash

replace-env-vars.sh /usr/share/jenkins/templates/config.tmpl /usr/share/jenkins/ref/config.xml
/usr/local/bin/jenkins.sh
