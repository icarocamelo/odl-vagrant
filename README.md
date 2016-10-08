OpenDaylight development environment
===========

Vagrant setup for OpenDaylight development environment

Uses Ubuntu Precise 14.04

## Vagrant box

> vagrant box add ubuntu64-trusty http://cloud-images.ubuntu.com/vagrant/trusty/20160927/trusty-server-cloudimg-amd64-vagrant-disk1.box

## Troubleshooting
You may have issues with virtualbox guest additions matching between your VB install and the base box.  If so, this is a handy plugin to help resolve that:
https://github.com/dotless-de/vagrant-vbguest

## Create a new OpenDaylight module

> mvn archetype:generate \
-DarchetypeGroupId=org.opendaylight.controller \
-DarchetypeArtifactId=opendaylight-startup-archetype \
-DarchetypeVersion=1.2.0-Boron \
-DarchetypeRepository=http://nexus.opendaylight.org/content/repositories/opendaylight.release/
-DarchetypeCatalog=http://nexus.opendaylight.org/content/repositories/opendaylight.release/archetype-catalog.xml


This is the structure of the generated project:

api  # contains the YANG model for your project
 |-- src/main/yang/demoproject.yang (YOU YANG GOES HERE)
 `-- pom.xml
impl # contains the project implementation
 |-- src/main/java
 | |-- com/cisco/impl/DemoProvider.java
 | `-- org/.../demoproject/impl/rev141210/DemoModule.java # Your module init class
 |-- src/main/yang/demoproject-impl.yang # YANG definition for your module config
 |-- src/main/config/default-config.xml  # Your module config file
 `-- pom.xml
features # contains the feature definition for Karaf
 |-- src/main/features/features.xml # defines features that can be installed in karaf
 `-- pom.xml
artifacts # maven project that includes all artifacts required by project
 `-- pom.xml # references demoproject-api, demoproject-impl, demoproject-features
karaf # maven project that builds an OpenDaylight karaf distribution
 `-- pom.xml # includes odl-demoproject-ui in the list of karaf local features
Without changing anything in the generated project, you can build the project and then run the generated Karaf distribution:
% cd demoproject
% mvn install
% ./karaf/target/assembly/bin/karaf

   ________                      ________                .__  .__      .__    __      
   \_____  \ ______  ____  ____ \______ \ _____  ___.__.|  | |__| ____ |  |___/  |_    
   /  |  \\____ \_/ __ \ /    \ |    |  \\__  \<  |  ||  | |  |/ ___\|  |  \  __\    
   /    |    \  |_> >  ___/|  |  \|    `  \/ __ \\___  ||  |_|  / /_/  >  Y  \  |      
   \_______  /  __/ \___  >___|  /_______  (____  / ____||____/__\___  /|___|  /__|      
           \/|__|        \/    \/        \/    \/\/            /_____/      \/          


Hit '<tab>' for a list of available commands
and '[cmd] --help' for help on a specific command.
Hit '<ctrl-d>' or type 'system:shutdown' or 'logout' to shutdown OpenDaylight.

opendaylight-user@root>feature:list | grep demoproject
odl-demoproject-api  | 1.0-SNAPSHOT | x  | odl-demoproject-1.0-SNAPSHOT | OpenDaylight :: demoproject :: api
odl-demoproject      | 1.0-SNAPSHOT | x  | odl-demoproject-1.0-SNAPSHOT | OpenDaylight :: demoproject
odl-demoproject-rest | 1.0-SNAPSHOT | x  | odl-demoproject-1.0-SNAPSHOT | OpenDaylight :: demoproject :: REST
odl-demoproject-ui  | 1.0-SNAPSHOT | x  | odl-demoproject-1.0-SNAPSHOT | OpenDay
