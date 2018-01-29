#!/bin/sh

. ./env-utils/utils.sh


# Base Xinitrc
s env-bash/.bashrc .bashrc
s env-bash/.bash_profile .bash_profile 


# Wicd
sudo systemctl enable wicd.service

#sudo systemctl enable dkms
#sudo modprobe vboxdrv
#echo "vboxdrv" >> /etc/modules-load.d/virtualbox.conf
#sudo dkms install vboxhost/$(pacman -Q virtualbox|awk {'print $2'}|sed 's/\-.\+//') -k $(uname -rm|sed 's/\ /\//')

#blue
#systemctl start bluetooth
#systemctl enable bluetooth
