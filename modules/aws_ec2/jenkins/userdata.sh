#!/usr/bin/env bash

# Configure secret
sh secret.sh

# update linux and install docker
sudo yum install docker  docker-compose git -y

# Install Docker machine
base=https://github.com/docker/machine/releases/download/v0.14.0 && curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && sudo install /tmp/docker-machine /usr/local/bin/docker-machine

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Configure Docker Machine
sudo usermod -aG docker $USER
docker-machine create --driver amazonec2 --amazonec2-access-key $ACCESS_KEY -amazonec2-secret-key $SECRET_KEY
docker-machine env aws02
docker-machine start aws02
chmod +x /usr/local/bin/docker-compose
//export DOCKER_HOST=127.0.0.1
sudo service docker start && docker-compose up -d
