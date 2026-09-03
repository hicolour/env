# General aliases + small utility functions.

# --- navigation: jump up N dirs ---
alias 1d="cd .."
alias 2d="cd ../.."
alias 3d="cd ../../.."
alias 4d="cd ../../../.."
alias 5d="cd ../../../../.."

# --- ls family ---
alias ls='ls -lah --color=auto'
alias la="ls -AFh"                    # list all
alias ld="ls -d */"                   # only directories
alias l.="ls -Ah | egrep '^\.'"       # only dotfiles
alias l1='ls -1AFh'                   # one per line
alias lg="ls -AFh | grep"             # grep filenames
alias lp='ls -d "$PWD"/*'             # full paths (evaluated at run time)
alias lpg='ls -d "$PWD"/* | grep'     # grep full paths
alias lt="ls -Alth"                   # by time
alias ltr="ls -Altrh"                 # by time, reversed
alias lss="ls -AFlSh"                 # by size
alias lsr="ls -AFlSrh"                # by size, reversed

# --- color everywhere ---
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff="diff --color=auto"
alias gr='grep --color -E'
alias ccat="highlight --out-format=ansi"   # syntax-highlighted cat

# --- misc ---
alias fh="find . -name "
alias myip="curl http://ipecho.net/plain; echo"
alias cs='xclip -selection clipboard'      # copy stdin to clipboard
alias vs='xclip -o -selection clipboard'   # paste clipboard to stdout
alias rofi='rofi -font "ypn envypn 10"'

# --- pacman / AUR (yay) ---
alias upg='yay -Syu --noconfirm; yay -Qtd'
alias y="yay --noconfirm"
# remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"

# --- docker ---
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# --- gron ---
alias norg="gron --ungron"
alias ungron="gron --ungron"

# --- git shortcuts ---
alias gpsd="git push origin develop"
alias gpld="git pull origin develop"
alias gpsm="git push origin master"
alias gplm="git pull origin master"
alias mergec="git merge --no-ff --no-commit"
alias gclean="git clean -d -f -f"

# --- system info ---
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'

# --- jvm / scala / maven ---
alias scala="scala -Dscala.color=true"
alias m="mvn clean install -DskipTests"

# extract almost any archive: extract <file>
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar e "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
