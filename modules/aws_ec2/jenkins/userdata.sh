#!/bin/sh

# Configure secret
export ACCESS_KEY=""
export SECRET_KEY=""

# update linux and install docker
sudo yum update -y
sudo yum install docker git -y

# Install Docker machine
base=https://github.com/docker/machine/releases/download/v0.14.0 && sudo curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# This needs to be change by the repos of jenkins docker compose
wget https://s3.us-east-2.amazonaws.com/terrajira-secterraform/jenkins.zip -P /tmp/
unzip /tmp/jenkins.zip
cd /jenkins/

# Configure Docker Machine
sudo usermod -aG docker $USER
sudo chmod +x /usr/local/bin/docker-compose

docker-machine create awsDocker --driver amazonec2 --amazonec2-access-key $ACCESS_KEY -amazonec2-secret-key $SECRET_KEY --amazonec2-region  us-east-2
docker-machine start awsDocker
docker-machine env awsDocker

eval $(docker-machine env awsDocker)
sudo service docker restart && docker-compose up -d