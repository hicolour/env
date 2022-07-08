#!/bin/bash
#
# Lightweight battery monitor.
#


source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


# TMP_MESURE_FILE="/tmp/status_power.tmp"


# if [ -f ${TMP_CPU_MESURE_FILE} ];
#     then
#         source ${TMP_MESURE_FILE}
#     else
#         PREV_REPORT=0
# fi


# Simplify https://www.reddit.com/r/learnpython/comments/ag3uw2/whats_wrong_with_directly_reading_battery_charge/ 

VERBOSE=0

TIMEOUT=120
DEVNAME_PATTERN='/org/freedesktop/UPower/devices/battery_BAT'

ALERTTHR=20
LOWTHR=40
FULL=95
EMPTY=10

power=""

battery_count=0

for i in 0 1
do
    DEVNAME=$DEVNAME_PATTERN$i

    exist=batteryLevel=`upower -i $DEVNAME`
    exist_count=`grep -o "null" <<<"$exist" | wc -l`

    if [ $exist_count -eq 0 ]
    then
            batteryLevel=`upower -i $DEVNAME |grep 'percentage' |grep -o '[0-9]*[\.0-9]*'| cut -d '.' -f1`
            state=`upower -i $DEVNAME | grep "state" | cut -d ':' -f2 | grep -o "[a-z]*"`
            if [ $VERBOSE -eq 1 ]
            then
              echo "Battery level: $batteryLevel"
              echo "Battery state:$state"
            fi

            if [ $EMPTY -gt $batteryLevel ]
            then
                notify-send "battery" "battery level is critical!: ${batteryLevel}%!"
            fi

            if [ $ALERTTHR -gt $batteryLevel ]
            then

                   if [ "$state" == "discharging" ]
             then

                    echo ''
                    # if [[ "$PREV_REPORT" =~ ^[0-9]+$ ]] && [ $PREV_REPORT -lt 1 ]
                    #     then
                    #         notify-send "battery" "battery level is near ${batteryLevel}%!"
                    #         PREV_REPORT=1
                    # fi

             fi
            fi

            

            timetoempty=`upower -i $DEVNAME | grep "time to empty" | cut -d ':' -f2 | grep -o "[0-9]*.[0-9] [h,m]"`
            timetofull=`upower -i $DEVNAME | grep "time to full" | cut -d ':' -f2 | grep -o "[0-9]*.[0-9] [h,m]"`

            icon=$ac_ing_icon
            color=$GREEN_BRIGHT

            battime=$timetofull
            if [ "$state" == "discharging" ]
             then

                    battime=$timetoempty

                    icon=$battery_full_icon
                    color=$GREEN_BRIGHT
                    if [ $FULL -gt $batteryLevel ]
                    then
                        icon=$battery_low_icon

                    fi

                    if [ $LOWTHR -gt $batteryLevel ]
                    then
                        icon=$battery_low_icon
                        color=$YELLOW_BRIGHT

                    fi

                    if [ $ALERTTHR -gt $batteryLevel ]
                    then
                        icon=$battery_crit_icon
                        color=$RED_BRIGHT
                    fi
            fi

            # space=""
            # if [ $battery_count -gt 0 ]
            #     then
            #     space=" "
            #     battery_count=1

            # else
            #     battery_count=$battery_count+1
            # fi



            power=$power"${WHITE_BRIGHT}${color} $(wrapper ${batteryLevel})% $battime"

            echo $timetoempty


    fi
done

sample "power.tmp" "$PREV_REPORT"

sample "power" "${WHITE_BRIGHT}${icon}$power"
