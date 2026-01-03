#!/bin/bash

echo "Testing dzen2 restart..."

# Kill existing dzen2 processes
pkill -f dzen2 || true

# Wait a moment
sleep 0.5

# Get current screen width
screen_width=$(xrandr | grep "Screen 0" | grep -o "current [0-9]*" | grep -o "[0-9]*")

# Fallback to 1000 if xrandr fails
if [ -z "$screen_width" ]; then
    screen_width=1000
fi

echo "Screen width: $screen_width"

# Launch main xmonad dzen2
dzen2 -y 0 -x 0 -w $screen_width -ta l -dock -fg '#E74C3C' -bg '#1B1B1B' -fn 'xft:misc ohsnap-11' -h 20 &

# Launch monitoring script
~/.dzen/dzen_xmonad.sh &

echo "Dzen2 restarted successfully"
