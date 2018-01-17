#!/bin/sh

. ./env-utils/utils.sh





# Bash
p bash-completion
p mlocate
p xclip

# SSH
p openssh
## Pass password to scirpts
p sshpass


# Editors
p vim
p atom

#y sublime-text

# Git
p git
p gitk

# Not exists
#y bash-completion-git


# Sound addons
## Base Sound controller
p pulseaudio-alsa
## GUI control for audio I/O
p pavucontrol
## Gui control for ALSA
p gnome-alsamixer

# Bluetoooth
y bluez
y bluez-utils

# Network
p wicd
p wicd-gtk


# Netstat
p net-tools


# Power managmentt
p upower
p powertop


# Virtualboc
p virtualbox
p virtualbox-host-dkms

# Wine
p wine

# VPN
p vpnc

# SSH tunel





# Communication
y skypeforlinux-bin
y google-talkplugin
p slack-desktop


# Music
y spotify

# Ebooks
p calibre


# Twitter
y hotot

y turpial
y pywebkitgtk

# Web
p firefox


# Subtitle editor
y subtitleeditor



#mindmapping
y xmind


# Display graphical dialog boxes from shell scripts
y zenity
