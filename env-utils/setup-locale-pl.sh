#!/bin/sh

. ./env-utils/utils.sh


line
color '34;1' "setup : locale-pl" 
line

localectl set-keymap pl
localectl set-x11-keymap pl
 
timedatectl set-timezone Europe/Warsaw
timedatectl status


# Network time protocol
sudo ntpd -qg

