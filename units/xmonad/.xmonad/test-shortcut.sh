#!/bin/bash

echo "Testing M-S-d shortcut..."
echo "Current dzen2 processes:"
ps aux | grep dzen2 | grep -v grep

echo ""
echo "Current screen width:"
xrandr | grep "Screen 0" | grep -o "current [0-9]*" | grep -o "[0-9]*"

echo ""
echo "Press M-S-d to test the screen change handler"
echo "This should restart dzen2 with the current screen width"
