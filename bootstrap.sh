#!/usr/bin/env bash

apt-get update
apt-get install -y maven git openjdk-7-jre openjdk-7-jdk unzip git
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
##Add to ~/.bashrc for persistence through a reboot##
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> ~/.bashrc

# To load mininet
git clone git://github.com/mininet/mininet
git checkout -b 2.1.0p1 2.1.0p1
sudo ./mininet/util/install.sh -n
sudo apt-get install -y mininet/precise-backports
