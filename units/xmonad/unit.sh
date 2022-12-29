#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link $UNIT_DIR/.xmonad $HOME/.xmonad