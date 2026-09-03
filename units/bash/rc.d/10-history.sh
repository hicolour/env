# History configuration + aliases.

HISTTIMEFORMAT="[%d/%m/%y %T] "

# Infinite history
HISTSIZE= HISTFILESIZE=

# Don't record noise or the fuzzy-history helpers themselves.
HISTIGNORE_SYSTEM="ls*:rm*:cd*:CD*:pwd:ps*:exit*:reset*:clear*:synaptic*:mkdir*:cat*:history*"
HISTIGNORE_CUSTOM="hs*:jp*"
export HISTIGNORE=$HISTIGNORE_SYSTEM":"$HISTIGNORE_CUSTOM

HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a"        # flush to histfile after every command

alias h='history'
alias hg='history | gr'
