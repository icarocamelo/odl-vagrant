#!/usr/bin/env bash

#Java 8
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk openjdk-8-jre

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

##Add to ~/.bashrc for persistence through a reboot##
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> ~/.profile

echo "Java is on version `java -version`"

sudo apt-get install -y unzip git

# Maven
sudo apt-get purge -y maven
wget http://mirror.its.dal.ca/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxf apache-maven-3.3.9-bin.tar.gz
sudo cp -R apache-maven-3.3.9 /usr/local
sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
echo 'Unseting M2_HOME..."
unset M2_HOME
echo 'Exporting new M2_HOME..."
echo "export M2_HOME=/usr/local/apache-maven-3.3.9" >> ~/.profile
export PATH=/usr/local/apache-maven-3.3.9/bin:$PATH

source ~/.profile

echo "Maven is on version `mvn --version`"

echo "ODL Maven settings.xml..."
sudo mkdir -p /home/vagrant/.m2/
sudo chmod -R 777 /home/vagrant/.m2/
sudo wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > /home/vagrant/.m2/settings.xml

echo 'Cloning OpenDaylight repositories..."
sudo git clone https://github.com/opendaylight/odlparent.git
sudo git clone https://github.com/opendaylight/yangtools.git
sudo git clone https://github.com/opendaylight/controller.git

cd /home/vagrant/odlparent
sudo git checkout -b beryllium remotes/origin/stable/beryllium
echo 'Compiling odlparent...'
sudo mvn clean install -DskipTests

cd /home/vagrant/yangtools
sudo git checkout -b beryllium remotes/origin/stable/beryllium
echo 'Compiling yangtools...'
sudo mvn clean install -DskipTests

cd /home/vagrant/controller
sudo git checkout -b beryllium remotes/origin/stable/beryllium
echo 'Compiling controller...'
sudo mvn clean install -DskipTests

mkdir /home/vagrant/yanglab
echo "**** VM setup successfully! *** "
echo "YANG lab base path: /home/vagrant/yanglab"
echo "To create your YANG lab you should execute the following command and set requested properties..."

echo "mvn archetype:generate \
-DarchetypeGroupId=org.opendaylight.controller \
-DarchetypeArtifactId=opendaylight-startup-archetype \
-DarchetypeVersion=1.2.0-Boron \
-DarchetypeRepository=http://nexus.opendaylight.org/content/repositories/opendaylight.release/ -DarchetypeCatalog=http://nexus.opendaylight.org/content/repositories/opendaylight.release/archetype-catalog.xml"
