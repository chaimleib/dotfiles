#!/bin/bash

[[ -z "$PS1" ]] && return

if [[ -n "$BASH_COMPLETION_COMPAT_DIR" ]]; then
    return
fi

bash_completion_candidates=(
    ~/.bash_completion
    )

for f in ${bash_completion_candidates[*]}; do
    if [[ -f "$f" ]]; then
        (( $BASHRC_debug >= 2 )) && echo "Sourcing $f ..."
        export BASH_COMPLETION="$f"
        export BASH_COMPLETION_DIR="${f}.d"
        export BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_DIR"
        . "$f"
        return
    fi
done

# Google Cloud SDK
[ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

