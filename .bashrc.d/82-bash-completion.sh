#!/bin/bash

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

