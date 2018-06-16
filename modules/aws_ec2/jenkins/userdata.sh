#!/bin/sh

# Configure secret
sh ././../../../creds/secret.sh

# update linux and install docker
sudo yum update -y
sudo yum install docker git -y

# Install Docker machine
base=https://github.com/docker/machine/releases/download/v0.14.0 && sudo curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# This needs to be change by the repos of jenkins docker compose
cp -r AWS-Jenkins-Docker /tmp/
cd /tmp/AWS-Jenkins-Docker

# Configure Docker Machine
sudo usermod -aG docker $USER
docker-machine create aws02 --driver amazonec2 --amazonec2-access-key $ACCESS_KEY -amazonec2-secret-key $SECRET_KEY --amazonec2-region  us-east-2
docker-machine start aws02
sudo chmod +x /usr/local/bin/docker-compose
eval $(docker-machine env aws02)
sudo service docker restart && docker-compose up -d