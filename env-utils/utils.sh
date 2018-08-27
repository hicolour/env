#!/bin/sh


var=$(pwd)
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

pp(){
      line
      color '32;1' "pip install : $@"
      line
      sudo pip install $@
}


y(){
      line
      color '32;1' "yaourt install : $@"
      line
      yaourt -S --noconfirm $@
      }

s(){
      line
      color '34;1' "setup : $1"
      color '35;1' "linking : $var/$1 to ~/$2"
      rm -rf ~/$2
      ln -s $var/$1 ~/$2
      }


info(){
  line
  color '32;1' "info : $@"
  line
}
