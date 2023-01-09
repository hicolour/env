#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# User needs to be aded to video group. Restart requured
# /usr/bin/xbacklight: [Errno 13] Permission denied: '/sys/class/backlight/intel_backlight/brightness'.

# https://gitlab.com/wavexx/acpilight

# Keyboard backlight control is also available on certain laptop models via the
# "leds" subsystem. The following laptop models are known to have a controllable
# keyboard backlight:

# Lenovo ThinkPad: -ctrl tpacpi::kbd_backlight

# Apple MacBook Pro: -ctrl smc::kbd_backlight

# Dell Latitude/XPS: -ctrl dell::kbd_backlight

# Asus N-Series Notebooks: -ctrl asus::kbd_backlight


# The following rules allow users in the video group to set the keyboard
# backlight as well:

# SUBSYSTEM=="leds", ACTION=="add", KERNEL=="*::kbd_backlight", \
#   RUN+="/bin/chgrp video /sys/class/leds/%k/brightness", \
#   RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"




sudo usermod -a -G video $USER

