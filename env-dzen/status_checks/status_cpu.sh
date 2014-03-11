#!/bin/bash
#
# Lightweight cpu monitor.
#


source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh

TMP_CPU_MESURE_FILE="/tmp/status_cpu.tmp"
TMP_CPU_FILE="/tmp/status_cpu"

if [ -f ${TMP_CPU_MESURE_FILE} ]; 
    then
        source ${TMP_CPU_MESURE_FILE}
    else
        PREV_TOTAL=0
        PREV_IDLE=0
fi

# cpu
CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

# Calculate the CPU usage since we last checked.
let "DIFF_IDLE=$IDLE-$PREV_IDLE"
let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

# Remember the total and idle CPU times for the next check.
echo "PREV_TOTAL="$TOTAL > $TMP_CPU_MESURE_FILE
echo "PREV_IDLE="$IDLE >> $TMP_CPU_MESURE_FILE

color=$GREEN_BRIGHT

if [ $DIFF_USAGE -gt 50 ]
then
    color=$YELLOW_BRIGHT
fi

if [ $DIFF_USAGE -gt 70 ]
    then
    color=$RED_BRIGHT
fi


cpu="${c15}${cpu_icon} ${color}$(wrapper ${DIFF_USAGE})%"

sample "cpu" "$cpu"

