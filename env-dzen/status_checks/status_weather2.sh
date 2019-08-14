#!/bin/sh

source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh



API_KEY AIzaSyBI0SYlKC6lyd8n_2aPV7cfZ7rQ3L5idyI

loc = $(curl -s "https://maps.googleapis.com/maps/api/browserlocation/json?browser=chrome&sensor=true&")

lat= $(echo $loc | jq -r ".location.lat")
lng= $(echo $loc | jq -r ".location.lng")



## output usage
usage () {
    echo ""
    echo "  Usage: weather [-chV] [-CF]"
    echo ""
    echo "  Options:"
    echo ""
    echo "    -c, --cached          use a cache"
    echo "    -h, --help            output help and usage"
    echo "    -V, --verison         output program version"
    echo ""
    echo "    -C, --celsius         check in Celcius"
    echo "    -F, --fahrenheit      check in Fahrenheit (default behavior)"
    echo ""
}

## get zipcode
zipcode () {
    echo $(curl --silent "http://ipinfo.io/" | grep -E '(postal|})' \
        | sed -e 's/"postal": "//' -e 's/}//' -e 's/"//' | tr -d '\n  ')
}

## get weather
getweather () {
    local zip=$(zipcode)
    echo $zip
    local unit="F"
    local ctail=""

    if [[ "$1" == "-C" ]]; then
        unit="C"
        ctail="&u=c"
    fi

    local weather=$(curl --silent                                        \
        "http://xml.weather.yahoo.com/forecastrss?p=${zip}${ctail}"      \
        | grep -E "(Current Conditions:|${unit}<BR)"                     \
        | sed -e "s/Current Conditions://" -e "s/<br \/>//" -e "s/<b>//" \
        -e "s/<\/b>//" -e "s/${unit}<BR \/>/º${unit}/" -e                \
        "s/<description>//" -e "s/<\/description>//"                     \
        | tr -d "\n")

    if [[ "$weather" == "" ]]; then
        echo "Cannot fetch weather"
        echo "Zip: ${zip}"
        exit 1
    else
        echo "$weather"
    fi
}

## use caching
cached () {
    ## time boundaries
    local modold=180 # 3 minutes
    local modnew=5   # 5 seconds
    local currtime=$(date +%s)

    ## temp unit
    local unit="F"
    [[ "$1" == "-C" ]] && unit="C"

    ## cache location setup
    local dir="weather.sh-cache"
    local file="$dir/weather-$VERSION-$unit.log"

    ## go to tmp dir
    cd $([ ! -z $TMPDIR ] && echo $TMPDIR || echo /tmp)

    ## if cache dir doesn't exist, make it
    if [[ ! -d "$dir" ]]; then
        mkdir "$dir"
        error=$?
        if [ ! "$error" -eq 0 ]; then
            echo "mkdir $dir failed"
            exit $error
        fi
    fi

    ## if cache file doesn't exist, make it
    set -o noclobber
    { > $file ; } &> /dev/null
    set +C

    ## set up diff as sec from now since file last modified
    local mod=$(stat -f%m "$file")
    let local diff=($currtime - $mod)

    ## load cached weather
    if [[ $diff -lt $modold && $diff -gt $modnew ]]; then
        local w=$(<$file)
        echo "$w"
        exit $?
    fi

    local w=$(getweather "${@}")
    echo "$w"
    echo "$w" > "$file"
}

## main
weather () {
    # local arg="$1"
    # shift

    # case "${arg}" in

    #     ## flags
    #     -V|--version)
    #         echo "${VERSION}"
    #         return 0
    #         ;;

    #     -h|--help)
    #         usage
    #         return 0
    #         ;;

    #     -C|--celsius)
    #         getweather
    #         return 0
    #         ;;

    #     -F|--fahrenheit)
    #         getweather
    #         return 0
    #         ;;

    #     -c|--cached)
    #         cached "${@}"
    #         return 0
    #         ;;

    # esac
    getweather
}

## export or run
#if [[ ${BASH_SOURCE[0]} != $0 ]]; then
#    export -f weather
#else
#    weather "${@}"
#    exit $?
#fi







#state=$(curl -s "http://xml.weather.yahoo.com/forecastrss?p=PLXX0012&amp&u=c" \
#| egrep -o 'temp="[^"]+"' | egrep -o '\-?[0-9]+')

#status="${c15}${weather_icon} ${state}°"

#sample "weather" "$status"

#$(curl -s "https://query.yahooapis.com/v1/public/yql -d q="select wind from weather.forecast where woeid=2460286" -d format=xml"  | egrep -o 'temp="[^"]+"' | egrep -o '\-?[0-9]+')

#$(curl -s "http://xml.weather.yahoo.com/forecastrss?p=PLXX0012&amp&u=c" | egrep -o 'temp="[^"]+"' | egrep -o '\-?[0-9]+')


#curl https://query.yahooapis.com/v1/public/yql -d q="select wind from weather.forecast where woeid=2460286" -d format=xml


#curl https://query.yahooapis.com/v1/public/yql -d q="select wind from weather.forecast where woeid=2460286" -d format=xml

#curl https://query.yahooapis.com/v1/public/yql -d q="select wind from weather.forecast where woeid=2460286"  -d format=json




#$(curl --silent "http://ipinfo.io/" | grep -E '(postal|})'  | sed -e 's/"postal": "//' -e 's/}//' -e 's/"//' | tr -d '\n  ')