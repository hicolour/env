#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo usermod -aG docker $USER
newgrp docker

sudo systemctl enable docker.service
sudo systemctl start docker.service
