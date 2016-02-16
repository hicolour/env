#!/bin/sh

. ./env-utils/utils.sh



# Latest JDK
#y jdk7


y intellij-idea-14-ultimate


# Building
p maven
y gradle

y npm

# App Container
#p tomcat7

# Scala Stack
p scala
p sbt


# Play! Framework
y playframework2

# MongoDB
p mongodb

# mysql
p mariadb

#y mysql-workbench

y python-sphinx 


y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service


# KVM 
p qemu dmidecode ebtables dnsmasq libvirt bridge-utils openbsd-netcat radvd urlgrabber virtviewer virt-manager ifplugd ifenslave tcl