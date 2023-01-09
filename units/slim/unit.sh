#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sudo systemctl enable slim.service
slink $UNIT_DIR/usr/share/slim/themes/slim-typesafe /usr/share/slim/themes/slim-typesafe
echo 'current_theme       slim-typesafe' | sudo tee --append /etc/slim.conf
