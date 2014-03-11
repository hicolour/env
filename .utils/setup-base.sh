#!/bin/sh

. ./.utils/utils.sh


# Base Xinitrc
s .xinitrc .xinitrc

# Xmonad config
s env-xmonad .xmonad

# Dzen config
s env-dzen	.dzen


# Config dir
mkdir -p ~/.config

# s .config/dunst 
# s .config/gtk-2.0
# s .config/gtk-3.0
# s .config/htop

# Dunst Config
s env-dunst .config/dunst 

# Midnight Commander
s env-mc .config/mc

# Roxterm
s env-roxterm .config/roxterm.sourceforge.net

