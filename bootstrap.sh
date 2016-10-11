#!/usr/bin/env bash

# Oracle Java 8
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
# Accept oracle license terms
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java8-installer

# Add to ~/.bashrc for persistence through a reboot
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.profile && source ~/.profile

echo "Java is on version `java -version`"

sudo apt-get install -y unzip git

# Maven
sudo apt-get purge -y maven
wget http://mirror.its.dal.ca/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxf apache-maven-3.3.9-bin.tar.gz
sudo cp -R apache-maven-3.3.9 /usr/local
sudo ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
echo 'Unseting M2_HOME...'
unset M2_HOME
echo 'Exporting new M2_HOME...'
echo "export M2_HOME=/usr/local/apache-maven-3.3.9" >> ~/.profile
echo "export MAVEN_OPTS='-Xmx1048m -XX:MaxPermSize=512m'" >> ~/.profile
echo "export PATH=/usr/local/apache-maven-3.3.9/bin:$PATH" >> ~/.profile

source ~/.profile

echo "Maven is on version `mvn --version`"

# Setting OpenDaylight repositories for both users (vagrant/root)
echo "ODL Maven settings.xml..."
mkdir -p /home/vagrant/.m2/
wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > /home/vagrant/.m2/settings.xml
sudo -s
mkdir -p /root/.m2/
wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > /root/.m2/settings.xml

echo "Cloning OpenDaylight repositories..."
git clone https://github.com/opendaylight/odlparent.git
git clone https://github.com/opendaylight/yangtools.git
git clone https://github.com/opendaylight/controller.git

cd odlparent
git checkout -b boron remotes/origin/stable/boron
echo 'Compiling odlparent...'
mvn clean install -DskipTests

cd yangtools
git checkout -b boron remotes/origin/stable/boron
echo 'Compiling yangtools...'
mvn clean install -DskipTests

cd controller
git checkout -b boron remotes/origin/stable/boron
echo 'Compiling controller...'
mvn clean install -DskipTests

mkdir /home/vagrant/yanglab
echo "**** VM setup successfully! *** "
echo "YANG lab base path: /home/vagrant/yanglab"
echo "To create your YANG lab you should execute the following command and set requested properties..."

echo "mvn archetype:generate \
-DarchetypeGroupId=org.opendaylight.controller \
-DarchetypeArtifactId=opendaylight-startup-archetype \
-DarchetypeVersion=1.2.0-Boron \
-DarchetypeRepository=http://nexus.opendaylight.org/content/repositories/opendaylight.release/ -DarchetypeCatalog=http://nexus.opendaylight.org/content/repositories/opendaylight.release/archetype-catalog.xml"
