# fzf-powered helpers: jump, history, process, git, files.

# Jump to project: every top-level dir under ~/projects, plus every git repo
# nested below it at any depth (node_modules pruned, no repo internals, no
# duplicates). Handles deeply nested work trees e.g. work/maropost/*/backend.
jp() {
  local dir
  dir=$(
    {
      find ~/projects -mindepth 1 -maxdepth 1 -type d
      find ~/projects -maxdepth 6 -name node_modules -prune -o \
           -name .git -print -prune 2>/dev/null | sed 's#/\.git$##'
    } | awk '!seen[$0]++' | fzf
  ) || return
  [ -n "$dir" ] && xdotool type "cd $dir"$'\n'
}

# History search: fuzzy-pick a past command (deduped, most-recent first) and
# type it at the prompt (does NOT run it - press Enter yourself). `hs foo`
# pre-fills the query.
hs() {
  local cmd
  cmd=$(
    history \
      | sed -E 's/^ *[0-9]+[[:space:]]+//; s/^\[[^]]*\][[:space:]]+//' \
      | tac | awk 'NF && !seen[$0]++' \
      | fzf +m --query="$*"
  ) || return
  [ -n "$cmd" ] && xdotool type -- "$cmd"
}

# Like hs, but also runs the picked command (types a trailing newline).
hsa() {
  local cmd
  cmd=$(
    history \
      | sed -E 's/^ *[0-9]+[[:space:]]+//; s/^\[[^]]*\][[:space:]]+//' \
      | tac | awk 'NF && !seen[$0]++' \
      | fzf +m --query="$*"
  ) || return
  [ -n "$cmd" ] && xdotool type -- "$cmd"$'\n'
}

# cg: alias for hs (was a near-identical duplicate).
cg() { hs "$@"; }

# jq key explorer: fjq [file]  (reads stdin if no file / '-')
fjq() {
  local input
  if [[ -z $1 ]] || [[ $1 == "-" ]]; then
    input=$(mktemp)
    trap 'rm -f "$input"' EXIT
    cat /dev/stdin > "$input"
  else
    input=$1
  fi
  jq -r 'keys[]' "$input" \
    | fzf --preview-window='up:85%' \
          --print-query \
          --preview "jq --color-output -r '.{}' $input"
}

# Fuzzy-pick a process and kill it: fkill [signal]
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

psk() { ps -afx | fzf | xargs -0 -I {} echo {} | awk '{ printf $1 }' | xargs -0 -I {} kill -9 {}; }

# --- git (fzf) ---
is_in_git_repo() { git rev-parse HEAD > /dev/null 2>&1; }

# checkout a branch (local via fbr / any via gb)
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

gf() {
  is_in_git_repo &&
    git -c color.status=always status --short |
    fzf --height 40% -m --ansi --nth 2..,.. | awk '{print $2}'
}

gb() {
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##' | xargs -I {} git checkout {}
}

gt() {
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 40% --multi
}

# git log picker (renamed from gh to avoid shadowing the GitHub CLI `gh`)
glg() {
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 40% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}

gr1() {
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq | fzf --height 40% --tac | awk '{print $1}'
}

# --- directory / file jumping ---
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fdr() {
  local dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

cf() {
  local file
  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"
  if [[ -n $file ]]; then
    if [[ -d $file ]]; then
      cd -- "$file"
    else
      cd -- "${file:h}"
    fi
  fi
}
