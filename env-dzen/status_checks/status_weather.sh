#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


state=$(curl -s "http://xml.weather.yahoo.com/forecastrss?p=PLXX0012&amp&u=c" \
| egrep -o 'temp="[^"]+"' | egrep -o '\-?[0-9]+')

status="${c15}${weather_icon} ${state}°"

sample "weather" "$status"