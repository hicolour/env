#!/bin/bash
. ~/.bin-env-xmonad/env-xmonad-utils/xspotify


#=== Settings ===#
SLEEP=10

speaker_icon="^i($HOME/.dzen/icons/spkr_01.xbm)"
mpd_icon="^i($HOME/.dzen/icons/mpd.xbm)"


#=== Loop ===#
while :; do

playback=$(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')

if [ $playback == "0%" ]
then
playback_format="000%"
elif [ $playback == "100%" ]
then
playback_format="${color_main}100%"
else
playback_format=$(printf "%04s" $playback | sed "s/ /0/g;s/\(^0\+\)/\1${color_main}/")
fi

volume="${color_sec1}${speaker_icon} ${color_sec2}${playback_format}"

# mpd
if [ ! `mpc | grep -o "\[.*\]"` == "[paused]" ]
then
  mpc_current=$(mpc current | sed 's/AnimeNfo Radio | Serving you the best Anime music!: //')
  mpc_current=$(echo $mpc_current | sed 's/AVRO Baroque Around The Clock: //')

  mpd="${color_sec1}${mpd_icon} ${color_main}${mpc_current}"
else
  mpd=""
fi

now now 
status status

spotify="${color_sec1}${status}${color_main} ${now}"

echo " $volume $spotify"

sleep $SLEEP; done
