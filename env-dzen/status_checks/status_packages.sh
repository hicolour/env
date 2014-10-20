#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh

yaourt -Sy --devel --aur > /dev/null 2>&1

status=$(pacman -Qu | wc -l)



# if [[ "$status" =~ ^[0-9]+$ ]] && [ $status -ge 1 ]
# then
#   echo $pacman_icon" "$status > /tmp/status_packages
#   notify-send "pacman" "$status packages to update"  -h string:bgcolor:#3B6B29 -h string:fgcolor:#D9FFCB
# elif [ -f "/tmp/status_packages" ]
# then
#   rm /tmp/status_packages
# fi


# status=$(curl -u ${gmail_login}:${gmail_password} \
# -s "https://mail.google.com/mail/feed/atom"\
# | grep -c "<entry>")



color=$WHITE_BRIGHT

if [ $status -gt 3 ]
then
    color=$YELLOW_BRIGHT
fi
if [ $status -gt 10 ]
then
    color=$RED_BRIGHT
fi

if [[ "$status" =~ ^[0-9]+$ ]]  #&& [ $status -ge 1 ]
then
	packages="${WHITE_BRIGHT}${pacman_icon} ${color}${status}"
	sample "packages" "$packages"
fi



 # notify-send "pacman" "$status packages to update"  -h string:bgcolor:#3B6B29 -h string:fgcolor:#D9FFCB