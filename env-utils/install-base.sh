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

y zukitwo-themes
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
p libnotify

# Fonts
p envypn-font
y ttf-envy-code-r

#Windows fonts
y fontconfig-ttf-ms-fonts
# http://nodehead.com/5-beautiful-gtk-themes-for-ubuntu/


# Windows Utils
p xorg-xprop

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
