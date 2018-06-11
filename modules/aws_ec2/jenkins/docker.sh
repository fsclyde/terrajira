#!/usr/bin/env bash
docker stop jenkins-nginx
docker stop jenkins-master
docker rm jenkins-nginx
docker rm jenkins-master
docker run -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins2
docker run -p 80:80 --name=jenkins-nginx --link jenkins-master:jenkins-master -d myjenkinsnginx
