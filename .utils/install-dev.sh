#!/bin/sh

. ./.utils/utils.sh



# Latest JDK
y jdk7

# Building
p maven
y gradle

# App Container
p tomcat7

# Scala Stack
p scala
p sbt


# Play! Framework
y playframework2

# MongoDB
p mongodb