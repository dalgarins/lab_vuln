#!/bin/bash

if [ -d /lab_vm ]
then
mkdir lab_vm
fi

cd lab_vm

echo "Installing sdk man"
sudo apt-get install curl
curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java
sdk install maven

source ~/.bashrc

echo "Installing docker"

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce

echo "starting service docker"
sudo systemctl start docker

export DOCKER_HOST=127.0.0.1:2375

echo "Installing docker compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "Installing OWASP ZAP"
wget https://github.com/zaproxy/zaproxy/releases/download/2.7.0/ZAP_2_7_0_unix.sh -O zap.sh
sudo chmod +x zap.sh
sudo ./zap.sh

echo "Installing burp-suite"
curl -o burp.sh -O "https://portswigger.net/burp/releases/download?product=community&version=1.7.36&type=linux"
chmod +x burp.sh
sudo ./burp.sh

echo "Installing web goat"
git clone https://github.com/WebGoat/WebGoat.git
cd WebGoat
git checkout master
mvn clean install
#mvn -pl webgoat-server spring-boot:run

cd..
echo "Installing dvwa"
sudo docker pull vulnerables/web-dvwa
sudo docker run --rm -it -p 80:80 vulnerables/web-dvwa
