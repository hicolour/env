#!/bin/sh

###########################################################################
# Set of base programs required to provide functional development enviroment
###########################################################################

. ./core/env.sh

apps=(
    git
    # jq
    # yq 
    # scala
    # sbt
    # intellij-idea-ultimate-edition
    # docer
    # docker-compose
)


env "${apps[@]}"

