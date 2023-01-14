#!/bin/sh

###########################################################################
# Set of base programs required to provide functional development enviroment
###########################################################################

. ./core/env.sh

apps=(
    jdk17-openjdk
    sbt
    ttf-fira-code                           # Editor font - mainly for Intellij
    intellij-idea-ultimate-edition

)


env "${apps[@]}"

