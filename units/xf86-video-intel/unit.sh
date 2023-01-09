#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

slink $UNIT_DIR/etc/X11/xorg.conf.d/20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf
