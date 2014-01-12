#!/bin/sh

color() {
      printf '\033[%sm%s\033[m\n' "$@"
      # usage color "31;5" "string"
      # 0 default
      # 5 blink, 1 strong, 4 underlined
      # fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
      # bg: 40 black, 41 red, 44 blue, 45 purple
      }
line(){
	echo ------------------------------------------------------------------
}
p(){
	line	
	color '32;1' "pacman install : $@"
	line
	sudo pacman -S --noconfirm $@
	}

y(){
      line  
      color '32;1' "pacman install : $@"
      line
      sudo yaourt -S --noconfirm $@
      }


p yaourt

p xmonad 
p xmonad-contrib
#p xmobar
p dzen2
p dmenu



# editors
p vim


# git utils
p git
p gitk
y bash-completion-git


p xloadimage

p mlocate
p bash-completion

#ssh tools
p openssh

p xclip

#sys tools
p upower
p powertop

# sys  network / netstat
p net-tools

#wifi
p wicd
sudo systemctl enable wicd.service

p wpa_supplicant
p wireless_tools

#sound
p alsa-utils


# general utils
p roxterm
p htop
p mc
p unzip
p unarar

#graphic tools
p imagemagick


# text editors
y sublime-text

# dev java
y jdk7

# build
p maven
y gradle

# server
p tomcat7

# virtualization
p virtualbox
#p virtualbox-host-modules
p virtualbox-host-dkms

# win on linux
p wine

#vpn
p vpnc


# messanger 
y skype
p pidgin
y google-talkplugin

# login manager
p slim
sudo systemctl enable slim.service

echo 'current_theme       archlinux-simplyblack' >> /etc/slim.conf

p slim-themes
p archlinux-themes-slim

# gtk
y gtk-engine-murrine  gtk-engines

y zukitwo-themes
y faience-icon-theme

#screen sjhoot
p scrot


# wallpaper
p feh

# notification manager
p dunst
p libnotify

# fonts
p envypn-font

# solaar - logitech mgmt

y solaar
 
