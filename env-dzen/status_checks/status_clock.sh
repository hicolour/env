#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh



#date

status="${c15}${clock_icon} $(date +%H:%M)"

sample "clock" "$status"
