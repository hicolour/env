#
# ~/.bashrc
#
# Slim loader. Interactive config lives in ~/.bashrc.d/*.sh:
#   public sections shipped by the env `bash` unit  (10-history, 20-aliases,
#   30-fzf, 40-git, 60-less, 90-prompt) plus any private overlay snippets.
#

# --- Environment (also needed by non-interactive shells) -------------------
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/
export PATH="$PATH:$JAVA_HOME/bin"

if [ -d "$HOME/.bin" ]; then
    PATH="$PATH:$HOME/bin/"
    for d in "$HOME"/.bin/*; do
        PATH="$PATH:$HOME/.bin/${d##*/}"
    done
    export PATH
fi

# --- Interactive shells only past this point -------------------------------
[[ $- != *i* ]] && return

# Disable ctrl-s / ctrl-q flow control; cd by bare dir name; append history.
[ -t 0 ] && stty -ixon
shopt -s autocd histappend

# Private, machine-local shell customizations.
[ -f ~/.personal/.private-bashrc ] && source ~/.personal/.private-bashrc

# Drop-in snippets: public sections (env bash unit) + private overlay units.
if [ -d ~/.bashrc.d ]; then
    for _f in ~/.bashrc.d/*.sh; do
        [ -r "$_f" ] && source "$_f"
    done
    unset _f
fi
