#!/bin/sh

. ./env-utils/utils.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link $UNIT_DIR/.bin $HOME/.bin
