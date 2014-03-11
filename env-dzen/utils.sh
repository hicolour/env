# -------------------
# FUNCTIONS
# -------------------
function wrapper {
if [ $1 -eq 0 ]
then
echo "000"
elif [ ${#1} -ge 3 ]
then
echo "$1"
else
echo $(printf "%03d" $1 | sed "s/\(^0\+\)/\1/")
fi
}

function sample {
if [[ ! $2 == "" ]]; then
  echo "$2" > /tmp/status_$1
elif [[ -f "/tmp/status_$1" ]]; then
  rm /tmp/status_$1
fi
}