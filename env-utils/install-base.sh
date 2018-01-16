#!/bin/sh

. ./env-utils/utils.sh

# Pkg Manager
p yaourt

# Xmonad

p xmonad
p xmonad-contrib

y xcompmgr

# Toolbar
p dzen2

# App Toolbar
p dmenu

#  Configure modifier keys to act as other keys when pressed and released on their own
y xcape

# inotify-tools is a C library and a set of command-line programs for Linux providing a  simple interface to inotify.
y inotify-tools


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
y gtk-engine-murrine  gtk-engines

y zukitwo-themes-git
y faience-icon-theme
y numix-themes
y gtk-theme-xgtk

# Fonts
y ttf-google-fonts-hg

# Screenshoots
p scrot


# Wallpaper
p feh
y imlibsetroot

# MNotification Manager
p dunst
# Library for sending desktop notifications
p libnotify

# Fonts
y envypn-font
y ttf-envy-code-r

#Windows fonts
y fontconfig-ttf-ms-fonts
# http://nodehead.com/5-beautiful-gtk-themes-for-ubuntu/


# Windows Utils
p xorg-xprop

# Control your EWMH compliant window manager from command line
y wmctrl



# Network time protocol
p ntp

#Json parser
#y jq


y thunar
# smb for thunar
y gvfs-smb


# exFat utilities
y exfat-utils

# vfat
y dosfstools

#alsi system info
y alsi



# Screencast tool to show your keys inspired by Screenflick, based on key-mon. Active fork with new features.
#y screenkey

# Cheat allows you to create and view interactive cheatsheets on the command-line
#y cheat-git
