#!/bin/bash

# Monitor for screen configuration changes
# This script can be run in the background to automatically restart dzen2 when screens change

last_width=""
while true; do
    current_width=$(xrandr | grep "Screen 0" | grep -o "current [0-9]*" | grep -o "[0-9]*")
    
    if [ -n "$current_width" ] && [ "$current_width" != "$last_width" ]; then
        echo "Screen width changed from $last_width to $current_width"
        # Restart dzen2 with new width
        ~/.xmonad/restart-dzen-dynamic.sh
        last_width="$current_width"
    fi
    
    sleep 2
done
