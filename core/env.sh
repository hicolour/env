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

link(){
      line
      color '34;1' "setup : $1"
      color '35;1' "linking : $1 to $2"
      # rm -rf ~/$2
      rm $2
      ln -s $1 $2
      }


env(){

      fname=$(basename $0)
      fbname=${fname%.*}

      units=($@)

      for package in ${units[@]}; do 
            if pacman -Qs $package > /dev/null; then
                  color '32;1' " $package"
            else
                  color '34;1' " $package"
            fi
      done

      echo
      read -p "Continue ? [Y/y]" -n 1 -r
      echo
      if ! [[ $REPLY =~ ^[Yy]$ ]]
      then 
            exit 0
      fi

      for package in ${units[@]}; do 
            
            # sudo pacman -S $unit
            if [[ -f "units/$package/unit.sh" ]]
            then
                  color '34;1' " $package"
                  units/$package/unit.sh
            fi
      done





}
