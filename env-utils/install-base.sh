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
p yaourt

#xorg
y xorg-server
y xorg-xinit
y xterm

# Xmonad
y xmonad
y xmonad-contrib

y xcompmgr

# Toolbar
y dzen2

# App Toolbar
y dmenu
y rofi

#  Configure modifier keys to act as other keys when pressed and released on their own
y xcape

# inotify-tools is a C library and a set of command-line programs for Linux providing a  simple interface to inotify.
y inotify-tools


# General Utils
y roxterm
y htop
y glances
y mc
y unzip
y unarar


# Login Manager
y slim
y slim-themes
y archlinux-themes-slim

# Gtk Themes
y gtk-engine-murrine  gtk-engines

# Gtk theme switcher - only needed if problems with theme
y gtk-theme-switch2

y zukitwo-themes-git
y faience-icon-theme


#y numix-themes
#y gtk-theme-xgtk

# Fonts
y ttf-google-fonts-hg

# Screenshoots
y scrot


# Wallpaper
y feh


# MNotification Manager
y dunst

# Library for sending desktop notifications
y libnotify

# Fonts
y envypn-font
y ttf-envy-code-r

#Windows fonts
# y fontconfig-ttf-ms-fonts   !!not found!!!
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

# Managment of the DOS filesystem - msotly mkfs.vfat, mkfs.msdos
p dosfstools

# Managment of the NTFS filesystem - msotly mkfs.ntsf
p ntfsprogs

# smb for thunar
p gvfs-smb

#alsi system info
p alsi


## Utitlities used in dozen status bars
# Calculate in bash
p bc

# Json parser
p jq


#
y upower


# Screencast tool to show your keys inspired by Screenflick, based on key-mon. Active fork with new features.
#y screenkey

# Cheat allows you to create and view interactive cheatsheets on the command-line
#y cheat-git
