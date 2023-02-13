#!/bin/sh

###########################################################################
# Set of base programs required to provide functional development enviroment
###########################################################################

. ./core/env.sh

apps=(
    git
    git-lfs
    jq
    postman-bin    
    docker
    dive-bin                # A tool for exploring each layer in a docker image
    docker-compose
)


env "${apps[@]}"

