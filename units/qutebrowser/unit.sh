#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Default profile is stored in $HOME/.config/qutebrowser/

mkdir -p $HOME/.config/qutebrowser/config
mkdir -p $HOME/.config/qutebrowser/data/userscripts
mkdir -p $HOME/tmp/download


link $UNIT_DIR/.config/qutebrowser/config/config.py $HOME/.config/qutebrowser/config/config.py
link $UNIT_DIR/.config/qutebrowser/config/autoconfig.yml $HOME/.config/qutebrowser/config/autoconfig.yml
link $UNIT_DIR/.config/qutebrowser/config/quickmarks $HOME/.config/qutebrowser/config/quickmarks

link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser/data/userscripts/qute-lastpass.py
link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-1password.py $HOME/.config/qutebrowser/data/userscripts/qute-1password.py



# Private profile 

mkdir -p $HOME/.config/qutebrowser-custom/private/config
mkdir -p $HOME/.config/qutebrowser-custom/private/data/userscripts


link $UNIT_DIR/.config/qutebrowser/config/config.py $HOME/.config/qutebrowser-custom/private/config/config.py
link $UNIT_DIR/.config/qutebrowser/config/autoconfig.yml $HOME/.config/qutebrowser-custom/private/config/autoconfig.yml

link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-lastpass.py
link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-1password.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-1password.py
link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-1pass $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-1pass


# Work profile 

mkdir -p $HOME/.config/qutebrowser-custom/work/config
mkdir -p $HOME/.config/qutebrowser-custom/work/data/userscripts


link $UNIT_DIR/.config/qutebrowser/config/config.py $HOME/.config/qutebrowser-custom/work/config/config.py
link $UNIT_DIR/.config/qutebrowser/config/autoconfig.yml $HOME/.config/qutebrowser-custom/work/config/autoconfig.yml

link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-lastpass.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-lastpass.py
link $UNIT_DIR/.config/qutebrowser/data/userscripts/qute-1password.py $HOME/.config/qutebrowser-custom/private/data/userscripts/qute-1password.py