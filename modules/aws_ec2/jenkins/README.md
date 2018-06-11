# AWS-Jenkins-Docker

### Prerequisites

* Install the following tools: docker, docker-machine, docker-compose 

### Usage

##### Configure the docker machine

    sudo usermod -aG docker $USER
    docker-machine create --driver amazonec2 --amazonec2-access-key [access key] --amazonec2-secret-key [secret key]
    docker-machine env aws02
    docker-machine start aws02
    
##### Starting docker & docker compose

    chmod +x /usr/local/bin/docker-compose
    export DOCKER_HOST=127.0.0.1
	eval "$(docker-machine env aws02)"
	sudo service docker start && docker-compose up -d

