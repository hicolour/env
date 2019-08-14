#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


WEATHER_REPORT_FILE=/tmp/weatherreport


testweather() {
	[ "$(stat -c %y $WEATHER_REPORT_FILE 2>/dev/null | cut -d' ' -f1)" != "$(date '+%Y-%m-%d')" ] &&
		ping -q -c 1 1.1.1.1 >/dev/null &&
		curl -s "wttr.in/$location" > $WEATHER_REPORT_FILE &&
		notify-send "Weather" "New weather forecast for today."
}

testweather

# If the weather report is current, show daily precipitation chance,
# low and high.  Don't even bother to understand this one unless you
# have all day. Takes the weather report format from wttr.in and makes
# it look like how I want it for the status bar.
status=$([ "$(stat -c %y $WEATHER_REPORT_FILE 2>/dev/null | cut -d' ' -f1)" = "$(date '+%Y-%m-%d')" ] &&
sed '16q;d' "$WEATHER_REPORT_FILE" | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/ /g" | tr -d '\n' &&
sed '13q;d' "$WEATHER_REPORT_FILE" | grep -o "m\\(-\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print "",$1"°",$2"°"}')



sample "weather" "${WHITE_BRIGHT}$weather_icon$status"
