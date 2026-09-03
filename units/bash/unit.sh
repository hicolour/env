#!/bin/sh

. ./core/env.sh

UNIT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link $UNIT_DIR/.bashrc $HOME/.bashrc
link $UNIT_DIR/.bash_profile $HOME/.bash_profile

# Public interactive sections -> ~/.bashrc.d/ (sourced by the slim .bashrc,
# alongside any private overlay snippets).
mkdir -p $HOME/.bashrc.d
for f in $UNIT_DIR/rc.d/*.sh; do
    link "$f" "$HOME/.bashrc.d/$(basename "$f")"
done
