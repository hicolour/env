#
# ~/.bashrc
#
 
# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
 
# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
 
 
 
# History
alias h='history'
HISTTIMEFORMAT="[%d/%m/%y %T] "


 
export HISTFILESIZE=100000
export HISTSIZE=100000 

# export HISTCONTROL=ignoreboth
# #export HISTCONTROL=erasedups
export HISTIGNORE="ls*:rm*:cd*:CD*:ps*:exit*:reset*:clear*:synaptic*:mkdir*:cat*"
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND="history -a"        # update histfile after every command

shopt -s histappend                       # append history file
 
alias hg='history | gr'
 
#Grep
 
alias gr='grep --color -E'
 
 
# ---------- @maven
MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=256m -XX:+CMSClassUnloadingEnabled -Dfile.encoding=UTF-8 -Djava.security.egd=file:///dev/urandom"
 
alias m="mvn clean install -DskipTests"
 
 
# ---------- @amartus-chameleon -------------
export AMARTUS_HOME=/home/marek/projects/amartus/chameleon/amartus_home
#export MODEL_HOME=/home/marek/projects/amartus/chameleon-deploy/model_home
 
export MODEL_HOME=/home/marek/projects/amartus/transition/model_home
#-verbose:class 
export CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
export JPDA_OPTS="-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n"
#-Dlog4j.configuration=file:/home/marek/projects/amartus/tmp/log4j.properties
export JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.config.file=/home/marek/projects/amartus/tmp/logging.properties -Dlog4j.configuration=file:/home/marek/projects/amartus/tmp/log4j.properties 
-Dorg.apache.catalina.connector.CoyoteAdapter.ALLOW_BACKSLASH=true 
-Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true -Dcom.sun.management.jmxremote=true \
                  -Dcom.sun.management.jmxremote.port=9090 \
                  -Dcom.sun.management.jmxremote.ssl=false \
                  -Dcom.sun.management.jmxremote.authenticate=false \
                  -Djava.rmi.server.hostname=mpr \
                  -Xmx2048M -Xmx6144M -XX:MaxPermSize=128M -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled"
export CATALINA_PID=/var/run/chameleondeploy.pid
 
export TOMCAT_JAVA_HOME=$JAVA_HOME


# SBT
export SBT_OPTS="-server -Xms512M -Xmx3000M -Xss1M  -XX:+UseConcMarkSweepGC -XX:NewRatio=8"


#
# ~/.bashrc
#
 
# G point
alias g='git'
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g
 
 
_complete_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    host_list=`{ 
        for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config
        do [ -r $c ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' $c
        done
        for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts
        do [ -r $k ] && egrep -v '^[#\[]' $k|cut -f 1 -d ' '|sed -e 's/[,:].*//g'
        done
        sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; }|tr ' ' '\n'|grep -v '*'`
    COMPREPLY=( $(compgen -W "${host_list}" -- ${cur##root@}))
    return 0
}
 
complete -F _complete_hosts ssh
complete -F _complete_hosts host
 
 
 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
 
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
 
# source ~/projects/experiment/bash-git-prompt/gitprompt.sh
 
#!/usr/bin/env bash
# Sexy bash prompt by twolfson
# https://github.com/twolfson/sexy-bash-prompt
# Forked from gf3, https://gist.github.com/gf3/306785
 
# If we are on a colored terminal
if tput setaf 1 &> /dev/null; then
  # Reset the shell from our `if` check
  tput sgr0 &> /dev/null
 
  # If you would like to customize your colors, use
  # # Attribution: http://linuxtidbits.wordpress.com/2008/08/11/output-color-on-bash-scripts/
  # for i in $(seq 0 $(tput colors)); do
  #   echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
  # done
 
  # Save common color actions
  prompt_bold="$(tput bold)"
  prompt_reset="$(tput sgr0)"
 
  # If the terminal supports at least 256 colors, write out our 256 color based set
  if [[ $(tput colors) -ge 256 ]] &> /dev/null; then
    prompt_user_color="$prompt_bold$(tput setaf 27)" # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)" # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 39)" # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 76)" # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 154)" # BOLD YELLOW
  else
  # Otherwise, use colors from our set of 8
    prompt_user_color="$prompt_bold$(tput setaf 4)" # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)" # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 6)" # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 2)" # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 3)" # BOLD YELLOW
  fi
 
  prompt_symbol_color="$prompt_bold" # BOLD
 
else
# Otherwise, use ANSI escape sequences for coloring
  # If you would like to customize your colors, use
  # DEV: 30-39 lines up 0-9 from `tput`
  # for i in $(seq 0 109); do
  #   echo -n -e "\033[1;${i}mText$(tput sgr0) "
  #   echo "\033[1;${i}m"
  # done
 
  prompt_reset="\033[m"
  prompt_user_color="\033[1;34m" # BLUE
  prompt_preposition_color="\033[1;37m" # WHITE
  prompt_device_color="\033[1;36m" # CYAN
  prompt_dir_color="\033[1;32m" # GREEN
  prompt_git_status_color="\033[1;33m" # YELLOW
  prompt_symbol_color="" # NORMAL
fi
 
# Apply any color overrides that have been set in the environment
if [[ -n "$PROMPT_USER_COLOR" ]]; then prompt_user_color="$PROMPT_USER_COLOR"; fi
if [[ -n "$PROMPT_PREPOSITION_COLOR" ]]; then prompt_preposition_color="$PROMPT_PREPOSITION_COLOR"; fi
if [[ -n "$PROMPT_DEVICE_COLOR" ]]; then prompt_device_color="$PROMPT_DEVICE_COLOR"; fi
if [[ -n "$PROMPT_DIR_COLOR" ]]; then prompt_dir_color="$PROMPT_DIR_COLOR"; fi
if [[ -n "$PROMPT_GIT_STATUS_COLOR" ]]; then prompt_git_status_color="$PROMPT_GIT_STATUS_COLOR"; fi
if [[ -n "$PROMPT_SYMBOL_COLOR" ]]; then prompt_symbol_color="$PROMPT_SYMBOL_COLOR"; fi
 
function get_git_branch() {
  # On branches, this will return the branch name
  # On non-branches, (no branch)
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ $ref != "" ]]; then
    echo $ref
  else
    echo "(no branch)"
  fi
}
 
is_branch1_behind_branch2 () {
  # $ git log origin/master..master -1
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit
 
  # Find the first log (if any) that is in branch1 but not branch2
  first_log="$(git log $1..$2 -1 2> /dev/null)"
 
  # Exit with 0 if there is a first log, 1 if there is not
  [[ -n "$first_log" ]]
}
 
branch_exists () {
  # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
  git branch --remote 2> /dev/null | grep --quiet "$1"
}
 
parse_git_ahead () {
  # Grab the local and remote branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"
 
  # $ git log origin/master..master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit
 
  # If the remote branch is behind the local branch
  # or it has not been merged into origin (remote branch doesn't exist)
  if (is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! branch_exists "$remote_branch"); then
    # echo our character
    echo 1
  fi
}
 
parse_git_behind () {
  # Grab the branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"
 
  # $ git log master..origin/master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit
 
  # If the local branch is behind the remote branch
  if is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    # echo our character
    echo 1
  fi
}
 
parse_git_dirty () {
  # ?? file.txt # Unstaged new files
  # A  file.txt # Staged new files
  #  M file.txt # Unstaged modified files
  # M  file.txt # Staged modified files
  #  D file.txt # Unstaged deleted files
  # D  file.txt # Staged deleted files
 
  # If the git status has *any* changes (i.e. dirty)
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    # echo our character
    echo 1
  fi
}
 
function is_on_git() {
  git rev-parse 2> /dev/null
}
 
function get_git_status() {
  # Grab the git dirty and git behind
  dirty_branch="$(parse_git_dirty)"
  branch_ahead="$(parse_git_ahead)"
  branch_behind="$(parse_git_behind)"
 
  # Iterate through all the cases and if it matches, then echo
  if [[ $dirty_branch == 1 && $branch_ahead == 1 && $branch_behind == 1 ]]; then
    echo "⬢"
  elif [[ $dirty_branch == 1 && $branch_ahead == 1 ]]; then
    echo "▲"
  elif [[ $dirty_branch == 1 && $branch_behind == 1 ]]; then
    echo "▼"
  elif [[ $branch_ahead == 1 && $branch_behind == 1 ]]; then
    echo "⬡"
  elif [[ $branch_ahead == 1 ]]; then
    echo "△"
  elif [[ $branch_behind == 1 ]]; then
    echo "▽"
  elif [[ $dirty_branch == 1 ]]; then
    echo "*"
  fi
}
 
get_git_info () {
  # Grab the branch
  branch="$(get_git_branch)"
 
  # If there are any branches
  if [[ "$branch" != "" ]]; then
    # Echo the branch
    output="$branch"
 
    # Add on the git status
    output=$output"$(get_git_status)"
 
    # Echo our output
    echo "$output"
  fi
}
 
# Symbol displayed at the line of every prompt
function get_prompt_symbol() {
  # If we are root, display `#`. Otherwise, `$`
  if [[ $UID == 0 ]]; then
    echo "#"
  else
    echo "\$"
  fi
}
 
# Define the sexy-bash-prompt
PS1="\[$prompt_user_color\]\u\[$prompt_reset\] \
\[$prompt_preposition_color\]at\[$prompt_reset\] \
\[$prompt_device_color\]\h\[$prompt_reset\] \
\[$prompt_preposition_color\]\h\[$prompt_reset\] \
\[$prompt_dir_color\]\w\[$prompt_reset\]\
\$( is_on_git && \
  echo -n \" \[$prompt_preposition_color\]on\[$prompt_reset\] \" && \
  echo -n \"\[$prompt_git_status_color\]\$(get_git_info)\" && \
  echo -n \"\[$prompt_preposition_color\]\") \[$prompt_reset\]\
\[$prompt_symbol_color\]$(get_prompt_symbol) \[$prompt_reset\]"
 
 
# PS1="\[$prompt_user_color\]\u\[$prompt_reset\] \
# \[$prompt_preposition_color\]at\[$prompt_reset\] \
# \[$prompt_device_color\]\h\[$prompt_reset\] \
# \[$prompt_preposition_color\]in\[$prompt_reset\] \
# \[$prompt_dir_color\]\w\[$prompt_reset\]\
# \$( is_on_git && \
#   echo -n \" \[$prompt_preposition_color\]on\[$prompt_reset\] \" && \
#   echo -n \"\[$prompt_git_status_color\]\$(get_git_info)\" && \
#   echo -n \"\[$prompt_preposition_color\]\")\n\[$prompt_reset\]\
# \[$prompt_symbol_color\]$(get_prompt_symbol) \[$prompt_reset\]"
 
# function __rvm_prompt {
#   if hash rvm-prompt 2>&- ; then
#     echo " `rvm-prompt i v g s`"
#   fi
# }
 
# function __git_prompt {
#   GIT_PS1_SHOWDIRTYSTATE=1
#   [ `git config user.pair` ] && GIT_PS1_PAIR="`git config user.pair`@"
#   __git_ps1 " $GIT_PS1_PAIR%s" | sed 's/ \([+*]\{1,\}\)$/\1/'
# }
 
# # Only show username@server over SSH.
# function __name_and_server {
#   if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#     echo "`whoami`@`hostname -s` "
#   fi
# }
 
# bash_prompt() {
 
#   # regular colors
#   local K="\[\033[0;30m\]"    # black
#   local R="\[\033[0;31m\]"    # red
#   local G="\[\033[0;32m\]"    # green
#   local Y="\[\033[0;33m\]"    # yellow
#   local B="\[\033[0;34m\]"    # blue
#   local M="\[\033[0;35m\]"    # magenta
#   local C="\[\033[0;36m\]"    # cyan
#   local W="\[\033[0;37m\]"    # white
 
#   # emphasized (bolded) colors
#   local BK="\[\033[1;30m\]"
#   local BR="\[\033[1;31m\]"
#   local BG="\[\033[1;32m\]"
#   local BY="\[\033[1;33m\]"
#   local BB="\[\033[1;34m\]"
#   local BM="\[\033[1;35m\]"
#   local BC="\[\033[1;36m\]"
#   local BW="\[\033[1;37m\]"
 
#   # reset
#   local RESET="\[\033[0;37m\]"
 
#   PS1="\t $BY\$(__name_and_server)$Y\W$G\$(__rvm_prompt)$G\$(__git_prompt)$RESET$ "
 
# }
 
 
 
# # /etc/bash.bashrc
# #
# # https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# #
# # This file is sourced by all *interactive* bash shells on startup,
# # including some apparently interactive shells such as scp and rcp
# # that can't tolerate any output. So make sure this doesn't display
# # anything or bad things will happen !
 
# # Test for an interactive shell. There is no need to set anything
# # past this point for scp and rcp, and it's important to refrain from
# # outputting anything in those cases.
 
# # If not running interactively, don't do anything!
# [[ $- != *i* ]] && return
 
# # Bash won't get SIGWINCH if another process is in the foreground.
# # Enable checkwinsize so that bash will check the terminal size when
# # it regains control.
# # http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# shopt -s checkwinsize
 
# # Enable history appending instead of overwriting.
# shopt -s histappend
 
# case ${TERM} in
# 	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
# 		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
# 		;;
# 	screen)
# 		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
# 		;;
# esac
 
# # fortune is a simple program that displays a pseudorandom message
# # from a database of quotations at logon and/or logout.
# # If you wish to use it, please install "fortune-mod" from the
# # official repositories, then uncomment the following line:
 
# # [[ "$PS1" ]] && /usr/bin/fortune
 
# # Set colorful PS1 only on colorful terminals.
# # dircolors --print-database uses its own built-in database
# # instead of using /etc/DIR_COLORS. Try to use the external file
# # first to take advantage of user additions. Use internal bash
# # globbing instead of external grep binary.
 
# # sanitize TERM:
# safe_term=${TERM//[^[:alnum:]]/?}
# match_lhs=""
 
# [[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
# [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
# [[ -z ${match_lhs} ]] \
# 	&& type -P dircolors >/dev/null \
# 	&& match_lhs=$(dircolors --print-database)
 
# if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
	
# 	# we have colors :-)
 
# 	# Enable colors for ls, etc. Prefer ~/.dir_colors
# 	if type -P dircolors >/dev/null ; then
# 		if [[ -f ~/.dir_colors ]] ; then
# 			eval $(dircolors -b ~/.dir_colors)
# 		elif [[ -f /etc/DIR_COLORS ]] ; then
# 			eval $(dircolors -b /etc/DIR_COLORS)
# 		fi
# 	fi
 
# 	PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "
 
# 	# Use this other PS1 string if you want \W for root and \w for all other users:
# 	# PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h\[\033[01;34m\] \W'; else echo '\[\033[01;32m\]\u@\h\[\033[01;34m\] \w'; fi) \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "
 
# 	alias ls="ls --color=auto"
# 	alias dir="dir --color=auto"
# 	alias grep="grep --color=auto"
# 	alias dmesg='dmesg --color'
 
# 	# Uncomment the "Color" line in /etc/pacman.conf instead of uncommenting the following line...!
 
# 	# alias pacman="pacman --color=auto"
 
# else
 
# 	# show root@ when we do not have colors
 
# 	PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "
 
# 	# Use this other PS1 string if you want \W for root and \w for all other users:
# 	# PS1="\u@\h $(if [[ ${EUID} == 0 ]]; then echo '\W'; else echo '\w'; fi) \$([[ \$? != 0 ]] && echo \":( \")\$ "
 
# fi
 
# PS2="> "
# PS3="> "
# PS4="+ "
 
# # Try to keep environment pollution down, EPA loves us.
# unset safe_term match_lhs
 
# # Try to enable the auto-completion (type: "pacman -S bash-completion" to install it).
# [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
 
# # Try to enable the "Command not found" hook ("pacman -S pkgfile" to install it).
# # See also: https://wiki.archlinux.org/index.php/Bash#The_.22command_not_found.22_hook
# [ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash
 
 
 
 
# function enrich {
#     flag=$1
#     symbol=$2
#     if [[ -n $3 ]]; then
#         coloron=$3
#     else
#         coloron=$on
#     fi
#     if [[ $use_color_off == false && $flag == false ]]; then symbol=' '; fi
#     if [[ $flag == true ]]; then color=$coloron; else color=$off; fi
#     PS1="${PS1}${color}${symbol}${reset} "
# }
 
# function build_prompt {
#     PS1=""    
#     # Git info
#     current_commit_hash=$(git rev-parse HEAD 2> /dev/null)
#     if [[ -n $current_commit_hash ]]; then is_a_git_repo=true; else is_a_git_repo=false; fi
    
#     if [[ $is_a_git_repo == true ]]; then
#         current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
#         if [[ $current_branch == 'HEAD' ]]; then detached=true; else detached=false; fi
    
#         number_of_logs=$(git log --pretty=oneline -n1 2> /dev/null | wc -l)
#         if [[ $number_of_logs -eq 0 ]]; then
#             just_init=true
#         else
#             upstream=$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
#             if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then has_upstream=true; else has_upstream=false; fi
 
#             git_status=$(git status --porcelain 2> /dev/null)
        
#             if [[ $git_status =~ ($'\n'|^).M ]]; then has_modifications=true; else has_modifications=false; fi
        
#             if [[ $git_status =~ ($'\n'|^)M ]]; then has_modifications_cached=true; else has_modifications_cached=false; fi
        
#             if [[ $git_status =~ ($'\n'|^)A ]]; then has_adds=true; else has_adds=false; fi
        
#             if [[ $git_status =~ ($'\n'|^).D ]]; then has_deletions=true; else has_deletions=false; fi
        
#             if [[ $git_status =~ ($'\n'|^)D ]]; then has_deletions_cached=true; else has_deletions_cached=false; fi
        
#             if [[ $git_status =~ ($'\n'|^)[MAD] && ! $git_status =~ ($'\n'|^).[MAD\?] ]]; then ready_to_commit=true; else ready_to_commit=false; fi
        
#             number_of_untracked_files=`echo $git_status | grep -c "^??"`
#             if [[ $number_of_untracked_files -gt 0 ]]; then has_untracked_files=true; else has_untracked_files=false; fi
        
#             tag_at_current_commit=$(git describe --exact-match --tags $current_commit_hash 2> /dev/null)
#             if [[ -n $tag_at_current_commit ]]; then is_on_a_tag=true; else is_on_a_tag=false; fi
        
#             has_diverged=false
#             can_fast_forward=false
        
#             if [[ $has_upstream == true ]]; then
#                 commits_diff=$(git log --pretty=oneline --topo-order --left-right ${current_commit_hash}...${upstream} 2> /dev/null)
#                 commits_ahead=$(grep -c "^<" <<< "$commits_diff")
#                 commits_behind=$(grep -c "^>" <<< "$commits_diff")
#             fi
#             if [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]]; then
#                 has_diverged=true
#             fi
#             if [[ $commits_ahead -eq 0 && $commits_behind -gt 0 ]]; then
#                 can_fast_forward=true
#             fi
        
#             will_rebase=$(git config --get branch.${current_branch}.rebase 2> /dev/null)
        
#             if [[ -f ${GIT_DIR:-.git}/refs/stash ]]; then
#                 number_of_stashes=$(wc -l 2> /dev/null < ${GIT_DIR:-.git}/refs/stash)
#             else
#                 number_of_stashes=0
#             fi
#             if [[ $number_of_stashes -gt 0 ]]; then has_stashes=true; else has_stashes=false; fi
#     fi
#     fi
    
#     if [[ $is_a_git_repo == true ]]; then
#         enrich $is_a_git_repo $is_a_git_repo_symbol $violet
#         enrich $has_stashes $has_stashes_symbol $yellow
#         enrich $has_untracked_files $has_untracked_files_symbol $red
#         enrich $has_adds $has_adds_symbol $yellow
    
#         enrich $has_deletions $has_deletions_symbol $red
#         enrich $has_deletions_cached $has_deletions_cached_symbol $yellow
    
#         enrich $has_modifications $has_modifications_symbol $red
#         enrich $has_modifications_cached $has_modifications_cached_symbol $yellow
#         enrich $ready_to_commit $ready_to_commit_symbol $green
        
#         enrich $detached $detached_symbol $red
    
#         if [[ $display_has_upstream == true ]]; then
#             enrich $has_upstream $has_upstream_symbol
#         fi
#         if [[ $detached == true ]]; then
#             if [[ $just_init == true ]]; then
#                 PS1="${PS1} ${red}detached"
#             else
#                 PS1="${PS1} ${on}(${current_commit_hash:0:7})"
#             fi
#         else
#             if [[ $has_upstream == true ]]; then
#                 if [[ $will_rebase == true ]]; then
#                     type_of_upstream=$rebase_tracking_branch_symbol
#                 else
#                     type_of_upstream=$merge_tracking_branch_symbol
#                 fi
                
#                 if [[ $has_diverged == true ]]; then
#                     PS1="${PS1}-${commits_behind} ${has_diverged_symbol} +${commits_ahead} "
#                 else
#                     if [[ $commits_behind -gt 0 ]]; then
#                         PS1="${PS1}${on} -${commits_behind} ${can_fast_forward_symbol} "
#                     fi
#                     if [[ $commits_ahead -gt 0 ]]; then
#                         PS1="${PS1}${on} ${should_push_symbol} +${commits_ahead} "
#                     fi
#                 fi
#                 PS1="${PS1}(${green}${current_branch}${reset} ${type_of_upstream} ${upstream//\/$current_branch/})"
#             else
#                 PS1="${PS1}${on}(${green}${current_branch}${reset})"
#             fi
#         fi
        
#         if [[ $display_tag == true && $is_on_a_tag == true ]]; then
#             PS1="${PS1} ${yellow}${is_on_a_tag_symbol}${reset}"
#         fi
#         if [[ $display_tag_name == true && $is_on_a_tag == true ]]; then
#             PS1="${PS1} ${yellow}[${tag_at_current_commit}]${reset}"
#         fi
#         PS1="${PS1}      "
#     fi
    
#     if [[ $two_lines == true && $is_a_git_repo == true ]]; then
#         break='\n'
#     else
#         break=''
#     fi
    
#     echo "${PS1}${reset}${break}${finally}"
# }
 
# if [ -n "${BASH_VERSION}" ]; then
#     DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
 
#     # Symbols
#     : ${is_a_git_repo_symbol:='❤'}
#     : ${has_untracked_files_symbol:='∿'}
#     : ${has_adds_symbol:='+'}
#     : ${has_deletions_symbol:='-'}
#     : ${has_deletions_cached_symbol:='✖'}
#     : ${has_modifications_symbol:='✎'}
#     : ${has_modifications_cached_symbol:='☲'}
#     : ${ready_to_commit_symbol:='→'}
#     : ${is_on_a_tag_symbol:='⌫'}
#     : ${needs_to_merge_symbol:='ᄉ'}
#     : ${has_upstream_symbol:='⇅'}
#     : ${detached_symbol:='⚯ '}
#     : ${can_fast_forward_symbol:='»'}
#     : ${has_diverged_symbol:='Ⴤ'}
#     : ${rebase_tracking_branch_symbol:='↶'}
#     : ${merge_tracking_branch_symbol:='ᄉ'}
#     : ${should_push_symbol:='↑'}
#     : ${has_stashes_symbol:='★'}
 
#     # Flags
#     : ${display_has_upstream:=false}
#     : ${display_tag:=false}
#     : ${display_tag_name:=true}
#     : ${two_lines:=true}
#     : ${finally:='\w ∙ '}
#     : ${use_color_off:=false}
 
#     # Colors
#     : ${on='\033[0;37m'}
#     : ${off='\033[1;30m'}
#     : ${red='\033[0;31m'}
#     : ${green='\033[0;32m'}
#     : ${yellow='\033[0;33m'}
#     : ${violet='\033[0;35m'}
#     : ${branch_color='\033[0;34m'}
#     : ${reset='\033[0m'}
    
#     PS2="${yellow}→${reset} "
    
#     source ${DIR}/base.sh
#     function bash_prompt() {
#         PS1="$(build_prompt)"
#     }
 
#     PROMPT_COMMAND=bash_prompt
# fi