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
p xorg-server
p xorg-xinit
p xterm

# Xmonad
p xmonad
p xmonad-contrib

p xcompmgr

# Toolbar
p dzen2

# App Toolbar
p dmenu
p rofi

#  Configure modifier keys to act as other keys when pressed and released on their own
p xcape

# inotify-tools is a C library and a set of command-line programs for Linux providing a  simple interface to inotify.
p inotify-tools


# General Utils
p roxterm
p htop
p glances
p mc
p unzip
p unarar


# Login Manager
p slim
p slim-themes
p archlinux-themes-slim

# Gtk Themes
p gtk-engine-murrine  gtk-engines

# Gtk theme switcher - only needed if problems with theme
p gtk-theme-switch2

p zukitwo-themes-git
p faience-icon-theme


#y numix-themes
#y gtk-theme-xgtk

# Fonts
p ttf-google-fonts-hg

# Screenshoots
p scrot


# Wallpaper
p feh


# MNotification Manager
p dunst

# Library for sending desktop notifications
p libnotify

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



# Screencast tool to show your keys inspired by Screenflick, based on key-mon. Active fork with new features.
#y screenkey

# Cheat allows you to create and view interactive cheatsheets on the command-line
#y cheat-git
