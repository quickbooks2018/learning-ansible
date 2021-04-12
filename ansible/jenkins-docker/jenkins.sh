#!/bin/bash
# OS: AmazonLinux
# https://github.com/javahometech/myapp-ansible


yum install -y docker
systemctl start docker
systemctl enable docker

docker run --name jenkins -u root -id -v "$PWD"/jenkins:/var/jenkins_home -p 80:8080 -p 50000:50000 --restart unless-stopped jenkins/jenkins:lts

docker exec -it jenkins apt update -y

docker exec -it jenkins apt install -y ansible

docker exec -it jenkins apt install -y git

# End
