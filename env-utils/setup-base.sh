#!/bin/sh

. ./env-utils/utils.sh


# Base Xinitrc
s env-xinitrc/.xinitrc .xinitrc

# Xmonad config
s env-xmonad .xmonad

# Dzen config
s env-dzen	.dzen


# Config dir
mkdir -p ~/.config

# s .config/dunst
# s gtk-2.0 .config/gtk-2.0
#s .gtk-3.0 .config/gtk-3.0
# s .config/htop

s env-gtk/.gtkrc-2.0 .gtkrc-2.0
s env-gtk/.gtkrc-3.0 .gtkrc-3.0

# Dunst Config
s env-dunst .config/dunst

# Midnight Commander
#s env-mc .config/mc

# Roxterm
s env-roxterm .config/roxterm.sourceforge.net

# wallpaper

s env-wallpaper/.wallpaper .wallpaper

info "Re-create base executables (bin)"
mkdir -p $HOME/.bin

# Bin setup
for d in env-bin/* ; do
    echo Removing $(basename $d)
    # rm -rf $HOME/.bin/$(basename $d)/
    s env-bin/$(basename $d) .bin/$(basename $d)
done



# Base slim theme
info "Enable and start login manager service"
sudo systemctl enable slim.service
sudo rm /usr/share/slim/themes/slim-typesafe
dir=$(pwd)
sudo ln -s  $dir/env-slim/slim-typesafe /usr/share/slim/themes/
#echo 'current_theme       archlinux-simplyblack' >> /etc/slim.conf
#echo 'current_theme       archlinux-simplyblack' | sudo tee --append /etc/slim.conf
echo 'current_theme       slim-typesafe' | sudo tee --append /etc/slim.conf


#Disable systems peaker
info "Disable systems speaker"
echo "blacklist pcspkr 1" > /tmp/nobeep.conf
sudo -s -- mv -f /tmp/nobeep.conf /etc/modprobe.d/nobeep.conf


#Enable USB headsets
info "Enable USB head sets"
echo "options snd slots=snd-usb-audio,snd-hda-intel" > /tmp/alsa.conf
sudo -s -- mv -f /tmp/alsa.conf /etc/modprobe.d/alsa.conf


info "Enable  and start network manager service"
sudo systemctl enable wicd
sudo systemctl start wicd
sudo systemctl status wicd



# FIXME
# SETUP KVM
#sudo modprobe kvm-intel
#sudo modprobe kvm
#sudo systemctl enable libvirtd.service
#sudo systemctl start libvirtd.service

# sudo rm -rf /etc/polkit-1/rules.d/50-org.libvirt.unix.manage.rules
# sudo touch /etc/polkit-1/rules.d/50-org.libvirt.unix.manage.rules
# sudo cat <<EOF > /etc/polkit-1/rules.d/50-org.libvirt.unix.manage.rules
# polkit.addRule(function(action, subject) {
# if (action.id == "org.libvirt.unix.manage" &&
#   subject.user == "tu_usuario") {
#   return polkit.Result.YES;
# }
# });
# EOF
