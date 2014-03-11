#!/bin/bash
#
# Lightweight mail monitor.
#


source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh



status=$(curl -u ${gmail_login}:${gmail_password} \
-s "https://mail.google.com/mail/feed/atom"\
| grep -c "<entry>")



color=$WHITE_BRIGHT

if [ $status -gt 0 ]
then
    color=$YELLOW_BRIGHT
fi


mail="${WHITE_BRIGHT}${mail_icon} ${color}${status}"

sample "mail" "$mail"


