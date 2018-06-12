#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
#xrandr --output DP1 --auto --right-of DP2 --auto


EXTERNAL_OUTPUT="DP1"
INTERNAL_OUTPUT="eDP1"


#xrandr --output eDP1 --mode 1920x1080 --left-of DP2
# xrandr --output DP2 --mode 1152x864

# xrandr | grep -w $EXTERNAL_OUTPUT | grep " connected "
# if [ $? -eq 0 ]; then
#   xrandr --output $INTERNAL_OUTPUT --off --output DP1 --auto --right-of DP2 --auto
# else
#  xrandr --output $INTERNAL_OUTPUT --on --auto
# fi

~/.personal/env-screen.sh


# --mode 1024x768
#xrandr --output DP2 --mode 1152x864 --rate 60 --left-of  eDP1 --auto

# DP2 1024x768_60.00
# xrandr --output eDP1 --auto --right-of DP1 --auto



#xrandr --output eDP1 --auto --left-of DP1 --auto --left-of DP2 --auto

xset m 6/1 1
xsetroot -cursor_name left_ptr


# Notifications
dunst &


# Java fix
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING


~/.dzen/status_checks/checker.sh &



#xrandr --output LVDS1 --auto --left-of HDMI1 --auto

#xrandr --output LVDS1 --auto --right-of VGA1 --auto

# sh ~/.utils/screen.sh


#setxkbmap -layout "rukbi_en, rukbi_ru" -option "grp:caps_toggle, grp_led:scroll, lv3:ralt_switch"
#xxkb &

# tools

# wallpaper
#sh ~/.fehbg &
#-fullscreen
#xloadimage -onroot
#imlibsetroot  --composite    ~/.wallpaper/w004.png &
#feh --bg-tile  ~/.wallpaper/bg-006.jpg &
feh --bg-scale  ~/.wallpaper/bg-006.jpg &

xbacklight -set 8 &

xcompmgr  &


# hotot-gtk2 &
#skype &
#turpial &
#spotify &

#google-chrome-stable https://mail.google.com/mail/u/0/#inbox &



#feh --bg-center ~/.wallpaper/thyon-04.jpg &

# notification engine -old
#twmnd &


# java fix
#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING



#export AWT_TOOLKIT=MToolkit


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

#roxterm --role roxterm_startup & roxterm --role roxterm_startup &

#sleep 1
#roxterm --role ranger_startup -e ranger &

#skype &
#pidgin &

# sleep 3 # n

# hotot-gtk3 &



exec xmonad
