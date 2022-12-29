#!/bin/sh

#-----------------------------------------------------------------------
# SUMMARY
#-----------------------------------------------------------------------
: << EOF

This script is essentially a heuristic for how I think about and manage work.

I use workspaces as "work contexts". Some are personal, some are general
work, some are for specific non-personal projects, some are personal but
warrant their own context.

This script will identify the current workspace name and then, based on
the command line arguments, return either a browser-tag, a browser-port
task-tag or task-context.

Browser tags / ports mean that the browser to be launched will be an
instance WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE to this workspace.

Task tags mean that my task list (taskwarrior) will be filtered using
the given tag.

Task contexts mean that a taskwarrior context will be applied.

TODO: test again under i3, gnome, etc. Most testing under xmonad to date.
for i3/gnome I'd probably want to map a numeric ws value to a list of
ws names prior to parsing.

EOF

#-----------------------------------------------------------------------
# USAGE
#-----------------------------------------------------------------------
: << EOF

ask 'ws' for the tag (or port) for either browser or task intances:

ws tag
ws port
ws context

EOF

#-----------------------------------------------------------------------
# WORKSPACE NAMES
#-----------------------------------------------------------------------

declare -A WORKSPACE_TAG_MAPPINGdef
declare -A WORKSPACE_CONTEXT_MAPPING


WORKSPACE_TAG_MAPPING=(
  ["wrk"]="WORK"            \
  ["tmp"]="INCOGNITO"       \
  ["priv"]="PERSONAL"       \
  ["gen"]="PERSONAL")

: <<EOF

MAP OF WORKSPACES

NAME    BROWSER-TAG    TASK-TAG    TASK-CONTEXT
GEN     per            per         per
PRIV    per            per         per
WRK     wrk            wrk         wrk
WRK:2   wrk            wrk         wrk
SYS     -              sys         per
DOM     -              dom         per
MON     -              sys         per
AV      -
NUL
TMP

EOF

# WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE BROWSER WORKSPACES
# list of workspaces that have a WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE browser instance AND show a WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE taskwarrior context
# these also likely have their own chat pplication handled via xmonad


if [[ -z $WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE ]]; then
  WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE='wrk ggc dm nul'
fi

# WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE WORKSPACES
# list of workspaces that automatically show an WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE mode browser


if [[ -z $WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE ]]; then
  WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE='void ano tmp'
fi


# DEFAULT
# all workspaces NOT listed in the above lists is considered default (personal)

#-----------------------------------------------------------------------
# MAIN
#-----------------------------------------------------------------------

main () {
    # future: map ws number to name
    #WM="$(wmctrl -m | head -n1 | cut -d " " -f2)"

    # WRK, wrk, WRK2, wrk:2 WRK:mon all normalize to 'wrk'
    WS=$(wmctrl -d |  grep '*' | rev | cut -d " " -f 1 | rev | cut -d ":" -f 2 | tr '[:upper:]' '[:lower:]' | cut -d: -f1 | tr -cd '[[:alpha:]]')
    [ -n "$WS" ] || { notify-send "$0 failed to get workspace name"; exit 1; }

    # echo $WS

    TAG="${WORKSPACE_TAG_MAPPING[$WS]}"
    # echo "TAG:"$TAG
    # CONTEXT="${WORKSPACE_TAG_MAPPING['$CONTEXT']]}"

    # WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE=$(echo $WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE | tr " " "\n" | grep $WS )
    # if [ -n "$WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE" ]
    # then
    #     TAG="WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE"
	  #     PORT=""
    # else
    #     TAG=$(echo $WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE $WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE | tr " " "\n" | grep $WS ) # not in WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE/WORKSPACE_NAME_WITH_INCOGNITO_BROWSER_PROFILE == default
    #     PORT_OFFSET=$(echo $WORKSPACE_NAME_WITH_UNIQUE_BROWSER_PROFILE | tr " " "\n" | grep -n $WS | cut -d: -f1) # int value based on position in list
    #     PORT=$(( 9222 + ${PORT_OFFSET:-0} ))
    # fi

    case $1 in
        port) echo -n "$PORT" ;;
        name) echo -n "$WS" ;;
        tag) echo -n "$TAG" ;;
        context) echo -n "$CONTEXT" ;;
        *|tag|task) echo -n "$TAG" ;;
    esac
}

#main $*
echo PERSONAL