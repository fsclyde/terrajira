#!/bin/sh

echo "
#install4j response file for JIRA Software 7.10.0
#Mon Jun 04 20:31:28 UTC 2018
launch.application$Boolean=true
rmiPort$Long=8005
app.jiraHome=/var/atlassian/application-data/jira
app.install.service$Boolean=true
existingInstallationDir=/opt/JIRA Software
sys.confirmedUpdateInstallationString=false
sys.languageId=en
sys.installationDir=/opt/atlassian/jira
executeLauncherAction$Boolean=true
httpPort$Long=8080
portChoice=default
" >> /tmp/response.varfile

JIRA="atlassian-jira-6.4.14-x64.bin"

wget https://www.atlassian.com/software/jira/downloads/binary/${JIRA} -P /tmp/
sudo sh /tmp/${JIRA} -q -varfile /tmp/response.varfile