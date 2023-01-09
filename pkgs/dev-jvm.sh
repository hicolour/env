#!/bin/sh

###########################################################################
# Set of base programs required to provide functional development enviroment
###########################################################################

. ./core/env.sh

apps=(
    jdk17-openjdk
    sbt
    intellij-idea-ultimate-edition

)


env "${apps[@]}"

