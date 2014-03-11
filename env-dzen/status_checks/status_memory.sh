#!/bin/bash
#
# Lightweight cpu monitor.
#


source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh



# # memory
memory_total=$(free -m | awk 'FNR == 2 {print $2}')
memory_used=$(free -m | awk 'FNR == 3 {print $3}')
memory_free_percent=$[$memory_used * 100 / $memory_total]


color=$GREEN_BRIGHT

if [ $memory_free_percent -gt 50 ]
then
    color=$YELLOW_BRIGHT
fi

if [ $memory_free_percent -gt 70 ]
    then
    color=$RED_BRIGHT
fi

memory="${c15}${mem_icon} ${color}$(wrapper ${memory_free_percent})%"

sample "memory" "$memory"

