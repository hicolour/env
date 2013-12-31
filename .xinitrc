#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrandr --output eDP1 --auto --left-of DP1 --auto


#xrandr --output LVDS1 --auto --left-of HDMI1 --auto

#xrandr --output LVDS1 --auto --right-of VGA1 --auto

# sh ~/.utils/screen.sh

# xorg
xsetroot -cursor_name left_ptr
#setxkbmap -layout "rukbi_en, rukbi_ru" -option "grp:caps_toggle, grp_led:scroll, lv3:ralt_switch"
#xxkb &

# tools

# wallpaper
#sh ~/.fehbg &
#xloadimage -onroot -fullscreen ~/.wallpaper/02-1920x1200.jpg &
feh --bg-center ~/.wallpaper/winter-1920x1200.jpg &


# notification engine -old
#twmnd &

# notifications engine
dunst &

# java fix
#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING



#export AWT_TOOLKIT=MToolkit

# cheks
~/.dzen/status_checks/checker.sh &

# apps

#(transmission-gtk & sleep 5 && wmctrl -xr transmission-gtk -t 7) &

#skype &
#mumble &

#(firefox & sleep 5 && wmctrl -xr firefox -t 0) &
#(gvim && wmctrl -xr gvim -t 1) &

#mpd &
#dropboxd &

#roxterm --role rails_dobroserver -e bash -c "cd /data/projects/dobroserver && rails s -p 2000" &
#roxterm --role rails_fitlog      -e bash -c "cd /data/projects/fitlog      && rails s -p 2001" &

#roxterm --role roxterm_startup &
#roxterm --role ranger_startup -e ranger &

exec xmonad
