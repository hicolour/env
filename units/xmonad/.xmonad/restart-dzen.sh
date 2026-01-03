#!/bin/bash

# Script to restart dzen2 status bar
# Usage: ./restart-dzen.sh

echo "Stopping existing dzen2 processes..."
pkill -f 'dzen2.*xmonad' || true

echo "Waiting for processes to stop..."
sleep 1

echo "Starting dzen2 status bar..."
# Get the dzen2 command from xmonad.hs
DZEN_CMD="dzen2 -y 0 -x 0 -w 1000 -ta l -dock -fg '#E74C3C' -bg '#1B1B1B' -fn 'xft:misc ohsnap-11' -h 20"

echo "Running: $DZEN_CMD"
$DZEN_CMD &

echo "Starting monitoring script..."
~/.dzen/dzen_xmonad.sh &

echo "Status bar restarted!"
echo "Check if dzen2 is running:"
ps aux | grep dzen2 | grep -v grep
