#!/usr/bin/env bash

apt-get update
apt-get install -y maven git openjdk-7-jre openjdk-7-jdk unzip git
git clone https://github.com/opendaylight/controller
git checkout stable/helium
cd controller
mvn clean install
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
##Add to ~/.bashrc for persistence through a reboot##
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc

# To load mininet
apt-get install -y mininet/precise-backports
