#!/bin/bash

#export color_main="^fg(#cdc5b3)"
export color_main="^fg(#d3d0c8)"
export color_sec1="^fg(#8ab3b5)"
export color_sec2="^fg(#747369)"

#export font="-*-terminus-medium-*-*-*-16-*-*-*-*-*-*-u"
#export font="-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1"
export font="-*-envypn-medium-*-*--13-*-*-*-*-*-*-1"
#font="Anonymous Pro 16"

#fg_color="#cdc5b3"
fg_color="#268bd2"
#bg_color="#0e0e0e"
#bg_color="#2a2a2a"
bg_color="#1B1B1B"

dzen_style="-fg $fg_color -bg $bg_color -fn $font -h 20 -e onstart=lower"

#1366x768


screen0_width=`xrandr | grep "Screen 0" | grep -o "current [0-9]*" |  grep -o "[0-9]*"`


~/.dzen/status_bars/dzen_main.sh      | dzen2 -y 0 -x 700  -w $screen0_width -ta r $dzen_style &
# ~/.dzen/status_bars/dzen_audio.sh     | dzen2 -y 0 -x 1920 -w 700  -ta l $dzen_style &
# ~/.dzen/status_bars/dzen_secondary.sh | dzen2 -y 0 -x 2200 -w 1320 -ta r $dzen_style &

# ~/.dzen/status_bars/dzen_main.sh      | dzen2 -y 0 -x 100  -w 1266 -ta r $dzen_style &
# ~/.dzen/status_bars/dzen_audio.sh     | dzen2 -y 0 -x 1366 -w 700  -ta l $dzen_style &
# ~/.dzen/status_bars/dzen_secondary.sh | dzen2 -y 0 -x 1966 -w 1320 -ta r $dzen_style &



# ~/.dzen/status_bars/dzen_main.sh      | dzen2 -y 0   -x 100 -w 1580 -ta r $dzen_style &
# ~/.dzen/status_bars/dzen_audio.sh     | dzen2 -y 0   -x 0 -w 100	-ta l $dzen_style &
# ~/.dzen/status_bars/dzen_secondary.sh | dzen2 -y 1030 	-x 1280 -w 400	-ta r $dzen_style &

