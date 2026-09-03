# sexy-bash-prompt (twolfson) - branch + dirty/ahead/behind glyphs.
# https://github.com/twolfson/sexy-bash-prompt  (forked from gf3)

# If we are on a colored terminal
if tput setaf 1 &> /dev/null; then
  tput sgr0 &> /dev/null

  prompt_bold="$(tput bold)"
  prompt_reset="$(tput sgr0)"

  if [[ $(tput colors) -ge 256 ]] &> /dev/null; then
    prompt_user_color="$prompt_bold$(tput setaf 27)"        # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)"  # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 39)"      # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 76)"         # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 154)" # BOLD YELLOW
  else
    prompt_user_color="$prompt_bold$(tput setaf 4)"         # BOLD BLUE
    prompt_preposition_color="$prompt_bold$(tput setaf 7)"  # BOLD WHITE
    prompt_device_color="$prompt_bold$(tput setaf 6)"       # BOLD CYAN
    prompt_dir_color="$prompt_bold$(tput setaf 2)"          # BOLD GREEN
    prompt_git_status_color="$prompt_bold$(tput setaf 3)"   # BOLD YELLOW
  fi
  prompt_symbol_color="$prompt_bold"
else
  prompt_reset="\033[m"
  prompt_user_color="\033[1;34m"        # BLUE
  prompt_preposition_color="\033[1;37m" # WHITE
  prompt_device_color="\033[1;36m"      # CYAN
  prompt_dir_color="\033[1;32m"         # GREEN
  prompt_git_status_color="\033[1;33m"  # YELLOW
  prompt_symbol_color=""                # NORMAL
fi

# Env overrides
if [[ -n "$PROMPT_USER_COLOR" ]]; then prompt_user_color="$PROMPT_USER_COLOR"; fi
if [[ -n "$PROMPT_PREPOSITION_COLOR" ]]; then prompt_preposition_color="$PROMPT_PREPOSITION_COLOR"; fi
if [[ -n "$PROMPT_DEVICE_COLOR" ]]; then prompt_device_color="$PROMPT_DEVICE_COLOR"; fi
if [[ -n "$PROMPT_DIR_COLOR" ]]; then prompt_dir_color="$PROMPT_DIR_COLOR"; fi
if [[ -n "$PROMPT_GIT_STATUS_COLOR" ]]; then prompt_git_status_color="$PROMPT_GIT_STATUS_COLOR"; fi
if [[ -n "$PROMPT_SYMBOL_COLOR" ]]; then prompt_symbol_color="$PROMPT_SYMBOL_COLOR"; fi

get_git_branch() {
  local ref
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ $ref != "" ]]; then echo $ref; else echo "(no branch)"; fi
}

is_branch1_behind_branch2() {
  local first_log
  first_log="$(git log $1..$2 -1 2> /dev/null)"
  [[ -n "$first_log" ]]
}

branch_exists() {
  git branch --remote 2> /dev/null | grep --quiet "$1"
}

parse_git_ahead() {
  local branch remote_branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"
  if (is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! branch_exists "$remote_branch"); then
    echo 1
  fi
}

parse_git_behind() {
  local branch remote_branch
  branch="$(get_git_branch)"
  remote_branch=origin/"$branch"
  if is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    echo 1
  fi
}

parse_git_dirty() {
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then echo 1; fi
}

is_on_git() { git rev-parse 2> /dev/null; }

get_git_status() {
  local dirty_branch branch_ahead branch_behind
  dirty_branch="$(parse_git_dirty)"
  branch_ahead="$(parse_git_ahead)"
  branch_behind="$(parse_git_behind)"
  if   [[ $dirty_branch == 1 && $branch_ahead == 1 && $branch_behind == 1 ]]; then echo "⬢"
  elif [[ $dirty_branch == 1 && $branch_ahead == 1 ]]; then echo "▲"
  elif [[ $dirty_branch == 1 && $branch_behind == 1 ]]; then echo "▼"
  elif [[ $branch_ahead == 1 && $branch_behind == 1 ]]; then echo "⬡"
  elif [[ $branch_ahead == 1 ]]; then echo "△"
  elif [[ $branch_behind == 1 ]]; then echo "▽"
  elif [[ $dirty_branch == 1 ]]; then echo "*"
  fi
}

get_git_info() {
  local branch output
  branch="$(get_git_branch)"
  if [[ "$branch" != "" ]]; then
    output="$branch$(get_git_status)"
    echo "$output"
  fi
}

get_prompt_symbol() {
  if [[ $UID == 0 ]]; then echo "#"; else echo "\$"; fi
}

PS1="\[$prompt_dir_color\] •\[$prompt_git_status_color\] •\[$prompt_device_color\] •\[$prompt_reset\]\[$prompt_reset\] \
\$( is_on_git && \
  echo -n \" \[$prompt_preposition_color\]on\[$prompt_reset\] \" && \
  echo -n \"\[$prompt_git_status_color\]\$(get_git_info)\" && \
  echo -n \"\[$prompt_preposition_color\]\") \[$prompt_reset\]\
\[$prompt_symbol_color\]$(get_prompt_symbol) \[$prompt_reset\]"
