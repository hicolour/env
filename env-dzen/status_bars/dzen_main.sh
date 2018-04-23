#!/bin/bash

# -------------------
# SETTINGS
# -------------------
icon_path="$HOME/.dzen/icons"

SLEEP=10

# net_down_icon="^i($HOME/.dzen/icons/net_down_03.xbm)"
# net_up_icon="^i($HOME/.dzen/icons/net_up_03.xbm)"

# fs_icon="^i($HOME/.dzen/icons/diskette.xbm)"

# cpu_icon="^i($HOME/.dzen/icons/cpu.xbm)"
# mem_icon="^i($HOME/.dzen/icons/mem.xbm)"

# clock_icon="^i($icon_path/clock.xbm)"



# # -------------------
# # FUNCTIONS
# # -------------------
# function wrapper {
# if [ $1 -eq 0 ]
# then
# echo "000"
# elif [ ${#1} -ge 3 ]
# then
# echo "${color_main}$1"
# else
# echo $(printf "%03d" $1 | sed "s/\(^0\+\)/\1${color_main}/")
# fi
#                  }

# function wrapper_net {
# if [ ${#1} -ge 4 ]
# then
# echo "${color_main}$1"
# else
# echo $(printf "%04s" $1 | sed "s/ /0/g;s/\(^0\+\)/\1${color_main}/")
# fi
#                      }

# ### network speed ###
# # Global variables
# interface=eth0
# received_bytes=""
# old_received_bytes=""
# transmitted_bytes=""
# old_transmitted_bytes=""

# # This function parses /proc/net/dev file searching for a line containing $interface data.
# # Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
# get_bytes()
# {
# transmitted_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)
# received_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
# }

# get_velocity()
# {
#     let vel=$1-$2

#     if [ $vel -ge 1024 ] && [ $vel -lt 1048576 ] ;
#     then
#       velKB=$[vel/1024];
#       echo "$(wrapper_net $velKB)K";
#     elif [ $vel -ge 1048576 ];
#     then
#       velMB=$(echo "scale=1; $vel/1048576" | bc)
#       echo "$(wrapper_net $velMB)M";
#     else
#       echo "$(wrapper_net $vel) ";
#     fi
# }

# # Gets initial values.
# get_bytes
# old_received_bytes=$received_bytes
# old_transmitted_bytes=$transmitted_bytes

# # cpu
# PREV_TOTAL=0
# PREV_IDLE=0

# ----------------------
# LOOP
# ----------------------
while :; do

# # network
# get_bytes

# vel_recv=$(get_velocity $received_bytes $old_received_bytes)
# vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes)

# network_speed_down="${color_sec1}${net_down_icon} ${color_sec2}$vel_recv"
# network_speed_up="${color_sec1}${net_up_icon} ${color_sec2}$vel_trans"

# old_received_bytes=$received_bytes
# old_transmitted_bytes=$transmitted_bytes

# # disk
# root_used=$(df /           | grep -Eo '[0-9]+%' | sed s/%//)
# var_used=$(df /var       | grep -Eo '[0-9]+%' | sed s/%//)
# usr_used=$(df /usr       | grep -Eo '[0-9]+%' | sed s/%//)
# home_used=$(df /home    | grep -Eo '[0-9]+%' | sed s/%//)
# data_used=$(df /home    | grep -Eo '[0-9]+%' | sed s/%//)

# root="${color_sec1}${fs_icon} / ${color_sec2}$(wrapper $root_used)%"
# var="${color_sec1}${fs_icon} /var ${color_sec2}$(wrapper $var_used)%"
# home="${color_sec1}${fs_icon} /home ${color_sec2}$(wrapper $home_used)%"
# usr="${color_sec1}${fs_icon} /usr ${color_sec2}$(wrapper $usr_used)%"
# data="${color_sec1}${fs_icon} /data ${color_sec2}$(wrapper $data_used)%"


# # cpu
# CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
# unset CPU[0]                          # Discard the "cpu" prefix.
# IDLE=${CPU[4]}                        # Get the idle CPU time.

# # Calculate the total CPU time.
# TOTAL=0
# for VALUE in "${CPU[@]}"; do
#   let "TOTAL=$TOTAL+$VALUE"
# done

# # Calculate the CPU usage since we last checked.
# let "DIFF_IDLE=$IDLE-$PREV_IDLE"
# let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
# let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

# # Remember the total and idle CPU times for the next check.
# PREV_TOTAL="$TOTAL"
# PREV_IDLE="$IDLE"

# cpu="${color_sec1}${cpu_icon} ${color_sec2}$(wrapper ${DIFF_USAGE})%"

# # memory
# memory_total=$(free -m | awk 'FNR == 2 {print $2}')
# memory_used=$(free -m | awk 'FNR == 3 {print $3}')
# memory_free_percent=$[$memory_used * 100 / $memory_total]
# mem="${color_sec1}${mem_icon} ${color_sec2}$(wrapper ${memory_free_percent})%"



# #date
# date="${color_sec1}${date_icon} ${color_main}$(date +'%A %B %d')"

# #clock
# clock="${color_sec1}${clock_icon} ${color_main}$(date +%H:%M)"



# dropbox_icon="dropbox.xbm"
# net_balance_icon="wired.xbm"
# packages_icon="pacman.xbm"
# rss_icon="dish.xbm"
# mail_icon="mail.xbm"
# weather_icon="temp.xbm"

# date_icon="^i($icon_path/date.xbm)"
# clock_icon="^i($icon_path/clock.xbm)"

#=== Functions ===#

# function ifexist {
# if [ -f /tmp/status_${1} ]; then
#   temp="${1}_icon"
#   icon="^i($icon_path/${!temp})"
#   echo "${color_sec1}${icon} ${color_main}$(cat /tmp/status_${1})  "
# fi
# }

function ifexist {
if [ -f /tmp/status_${1} ]; then
  echo "$(cat /tmp/status_${1})  "
fi
}


#=== Loop ===#
while :; do

dropbox="$(ifexist dropbox)"
net_balance="$(ifexist net_balance)"
packages="$(ifexist packages)"
rss="$(ifexist rss)"
mail="$(ifexist mail)"
weather="$(ifexist weather)"
power="$(ifexist power)"
cpu="$(ifexist cpu)"
memory="$(ifexist memory)"
date="$(ifexist date)"
clock="$(ifexist clock)"
net="$(ifexist net)"
currency="$(ifexist currency)"
crypto_miner="$(ifexist crypto_miner)"
crypto_market="$(ifexist crypto_market)"


#${mail}${rss}${weather}${crypto_miner}
#${crypto_miner}${crypto_market}${currency}
echo "${net}${memory}${cpu}${power}${dropbox}${net_balance}${packages}${date}${clock}"

sleep 1; done



#echo "$root $var $usr $home   $cpu  $mem  $power  $clock "
# echo "$root $home $var $data | $cpu $mem | $power0 $power $date $clock  "
# echo "$cpu $mem $power0 $power $date $clock  "


sleep $SLEEP; done
