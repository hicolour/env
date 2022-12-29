#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


#date
date="${c15}${date_icon}$(date +'%b %d')"

sample "date" "$date"
