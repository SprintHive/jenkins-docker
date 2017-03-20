#/bin/bash

# Expand templates
for template in /usr/share/jenkins/templates/*.tmpl; do
  destinationFile=/usr/share/jenkins/ref/$(echo -n ${template##*/} | sed 's/tmpl/xml/')
  replace-env-vars.sh $template $destinationFile
done;

# Run jenkins
/usr/local/bin/jenkins.sh
