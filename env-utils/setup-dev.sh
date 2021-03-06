
#!/bin/sh

. ./env-utils/utils.sh


info "Enabling jdk 10"
sudo archlinux-java set java-10-jdk

#Docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker $USER
newgrp docker



# color() {
#       printf '\033[%sm%s\033[m\n' "$@"
#       # usage color "31;5" "string"
#       # 0 default
#       # 5 blink, 1 strong, 4 underlined
#       # fg: 31 red,  32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
#       # bg: 40 black, 41 red, 44 blue, 45 purple
#       }
# line(){
# 	echo ------------------------------------------------------------------
# }
# s(){
# 	line
# 	color '34;1' "setup : $@"
# 	line
# 	rm -rf ~/$2
# 	ln -s $var/$1 ~/$2
# 	}
#
#
# var=$(pwd)
#
#
# # s .bin-env-xmonad
#
# s .xinitrc .xinitrc
#
# s env-xmonad .xmonad
# s env-dzen	.dzen
#
#
# # Config dir
# mkdir -p ~/.config
#
# # s .config/dunst
# # s .config/gtk-2.0
# # s .config/gtk-3.0
# # s .config/htop
#
# s env-dunst .config/dunst
# s env-mc .config/mc
# s env-roxterm .config/roxterm.sourceforge.net
#
#
# # env-git
# s env-git/.gitconfig .gitconfig
# s env-git/.gitignore .gitignore
#
# git config --global core.excludesfile '~/.gitignore'
#
# # s .config/twmn
#
#
