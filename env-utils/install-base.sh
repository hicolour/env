#!/bin/sh

. ./env-utils/utils.sh

# Pkg Manager
p yaourt

# Xmonad

p xmonad 
p xmonad-contrib

# Toolbar
p dzen2

# App Toolbar
p dmenu

# General Utils
p roxterm
p htop
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


# Windows Utils
p xorg-xprop

# Network time protocol
p ntp

#Json parser
#y jq
