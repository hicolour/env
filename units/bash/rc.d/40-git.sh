# git shortcut with completion, plus ssh host completion.

alias g='git'
if [ -r /usr/share/bash-completion/completions/git ]; then
  source /usr/share/bash-completion/completions/git
  complete -o default -o nospace -F _git g
fi

# Complete ssh/host targets from ssh configs, known_hosts and /etc/hosts.
_complete_hosts() {
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local host_list
  host_list=$( {
    for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config; do
      [ -r "$c" ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' "$c"
    done
    for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts; do
      [ -r "$k" ] && egrep -v '^[#\[]' "$k" | cut -f 1 -d ' ' | sed -e 's/[,:].*//g'
    done
    sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; } | tr ' ' '\n' | grep -v '*' )
  COMPREPLY=( $(compgen -W "${host_list}" -- ${cur##root@}) )
  return 0
}
complete -F _complete_hosts ssh
complete -F _complete_hosts host
