OpenDaylight development environment
===========

Vagrant setup for OpenDaylight development environment

Uses Ubuntu Precise 14.04

## Vagrant box

> vagrant box add ubuntu64-trusty http://cloud-images.ubuntu.com/vagrant/trusty/20160927/trusty-server-cloudimg-amd64-vagrant-disk1.box

## Troubleshooting
You may have issues with virtualbox guest additions matching between your VB install and the base box.  If so, this is a handy plugin to help resolve that:
https://github.com/dotless-de/vagrant-vbguest
