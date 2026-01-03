#!/bin/bash

# Get the current screen width dynamically
screen_width=$(xrandr | grep "Screen 0" | grep -o "current [0-9]*" | grep -o "[0-9]*")

# Fallback to 1000 if xrandr fails
if [ -z "$screen_width" ]; then
    screen_width=1000
fi

# Launch dzen2 with dynamic width
dzen2 -y 0 -x 0 -w $screen_width -ta l -dock -fg '#E74C3C' -bg '#1B1B1B' -fn 'xft:misc ohsnap-11' -h 20
