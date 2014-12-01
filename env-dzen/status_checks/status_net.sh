#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh



disoc="disconnected"

RAW_WIRELESS=`wicd-cli --wireless -d`

RAW_WIRELESS_IVALID=`wicd-cli --wireless -d | grep Invalid`

RAW_WIRELESS_IVALID=`wicd-cli --wireless -d | grep Invalid`


if [[ "$RAW_WIRELESS" != "" && "$RAW_WIRELESS_IVALID" = "" ]]; then
    ip=`wicd-cli --wireless -d | grep "IP:" \
        | grep -oE "([0-9]*\.){3}[0-9]?{3}"`

    quality=`wicd-cli --wireless -d | grep Quality: | grep -o "[0-9]*"`

    color=$GREEN_BRIGHT
    if [ $quality -lt 30 ]
	then
    	color=$RED_BRIGHT
	fi

	if [ $quality -lt 70 ]
	    then
	    color=$YELLOW_BRIGHT
	fi

   	wireless="${c15}${wireless_high_icon} ${color}${quality}% ${BLACK_BRIGHT}$ip"

else
	wireless="${c15}${wireless_disconnected_icon} ${BLACK_BRIGHT}disconnected"
fi


sample "net" "$wireless"