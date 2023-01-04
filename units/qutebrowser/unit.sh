#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Default profile is stored in $HOME/.config/qutebrowser/

mkdir -p $HOME/.config/qutebrowser/config
mkdir -p $HOME/.config/qutebrowser/data/userscripts


link $UNIT_DIR/.config/qutebrowser/config/config.py $HOME/.config/qutebrowser/config/config.py
link $UNIT_DIR/.config/qutebrowser/config/autoconfig.yml $HOME/.config/qutebrowser/config/autoconfig.yml
link $UNIT_DIR/.config/qutebrowser/config/quickmarks $HOME/.config/qutebrowser/config/quickmarks

link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser/data/userscripts/qute-lastpass.py


# Private profile 

mkdir -p $HOME/.config/qutebrowser-custom/private/config
mkdir -p $HOME/.config/qutebrowser-custom/private/data/userscripts


link $UNIT_DIR/.config/qutebrowser-custom/private/config/config.py $HOME/.config/qutebrowser-custom/private/config/config.py

link $UNIT_DIR/.config/qutebrowser-custom/private/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-lastpass.py


# Work profile 

mkdir -p $HOME/.config/qutebrowser-custom/work/config
mkdir -p $HOME/.config/qutebrowser-custom/work/data/userscripts


link $UNIT_DIR/.config/qutebrowser-custom/work/config/config.py $HOME/.config/qutebrowser-custom/work/config/config.py

link $UNIT_DIR/.config/qutebrowser-custom/work/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-lastpass.py