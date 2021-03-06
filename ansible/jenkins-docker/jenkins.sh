#!/bin/bash


yum update -y

yum install -y docker nc
systemctl start docker
systemctl enable docker

docker run --name jenkins -u root -id -v "$PWD"/jenkins:/var/jenkins_home -p 80:8080 -p 50000:50000 -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock --restart unless-stopped quickbooks2018/jenkins-ansible-maven:latest

while ! nc -vz 127.0.0.1 80;do echo "Waiting for port" && sleep 5;done

sleep 30

docker exec -it jenkins apt update -y

docker exec -it jenkins apt install -y ansible

docker exec -it jenkins apt install -y git

docker exec -it jenkins apt install -y maven

docker exec -it jenkins which mvn

docker exec -it jenkins mvn --version

amazon-linux-extras install ansible2 -y


#END
