#!/bin/sh

###########################################################################
# Set of base programs required to provide functional development enviroment
###########################################################################

. ./core/env.sh

apps=(
    git
    git-lfs
    jq
    # yq 
    docker
    docker-compose
)


env "${apps[@]}"

