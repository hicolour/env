#!/bin/sh

###########################################################################
# Set of base programs required to provide functional desktop enviroment
#
# * Login manager
# * Tiling windows manager
# * Status bar
# * Application launcher
# * Wallpaper launcher
# * Basic file managment
# * Network managment
# * Actual time manager
# * Basic web browsing
###########################################################################

. ./env-utils/utils.sh

# Pkg Manager
#p yaourt

# Pacman utilities e.g. rankmirrors
p pacman-contrib


#xorg
p xorg-server
p xorg-xinit
p xterm

# Xmonad
p xmonad
p xmonad-contrib

p xcompmgr

p xorg-xrandr

# Toolbar
p dzen2

# App Toolbar
p dmenu
p rofi

#  Configure modifier keys to act as other keys when pressed and released on their own
p xcape

# inotify-tools is a C librarp and a set of command-line programs for Linux providing a  simple interface to inotify.
p inotify-tools


# General Utils
p htop
p glances
p mc
p unzip

# A CLI system information tool written in BASH that supports displaying images. 
p neofetch

# Login Manager
p slim
p slim-themes
p archlinux-themes-slim

# Gtk Themes
p gtk-engine-murrine  gtk-engines

# Gtk theme switcher - onlp needed if problems with theme
p gtk-theme-switch2



#p numix-themes
#p gtk-theme-xgtk


# Screenshoots
p scrot


# Wallpaper
p feh


# MNotification Manager
p dunst


# Librarp for sending desktop notifications
p libnotify



#Windows fonts
# p fontconfig-ttf-ms-fonts   !!not found!!!
# http://nodehead.com/5-beautiful-gtk-themes-for-ubuntu/


# Windows Utils
p xorg-xprop

# Control your EWMH compliant window manager from command line
p wmctrl

# Network time protocol
p ntp




# Graphical file manager
p thunar


# Network manager

# Web browser
p qutebrowser

# Pip install for python module instllation
p python-pip

# Additional module required bp qutebrowser lastpass userscript
p tldextract
python /usr/share/qutebrowser/scripts/dictcli.pp install en-US
python /usr/share/qutebrowser/scripts/dictcli.pp install pl-PL


# Sound addons
## Base Sound controller
p pulseaudio-alsa
## GUI control for audio I/O
p pavucontrol
## Gui control for ALSA
p gnome-alsamixer


## File systems managment
# exFat utilities
p exfat-utils

# Managment of the DOS filesystem - msotlp mkfs.vfat, mkfs.msdos
p dosfstools

# Managment of the NTFS filesystem - msotlp mkfs.ntsf
p ntfsprogs

# smb for thunar
p gvfs-smb



## Utitlities used in dozen status bars
# Calculate in bash
p bc

# Json parser
p jq


#
p upower


# Screencast tool to show your keys inspired bp Screenflick, based on key-mon. Active fork with new features.
#p screenkey

# Cheat allows you to create and view interactive cheatsheets on the command-line
#p cheat-git

##################################
# YAOURT required => AUR
##################################
y roxterm

y unarar

# Fonts
y envypn-font
y ttf-envy-code-r

#alsi system info
y alsi

# Fonts
y ttf-google-fonts-hg


y faience-icon-theme
y zukitwo-themes-git
