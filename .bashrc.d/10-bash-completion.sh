#!/bin/bash

[[ -z "$PS1" ]] && return
[[ -n "$BASH_COMPLETION_COMPAT_DIR" ]] && return

if [[ "$0" == *bash ]]; then
    bash_completion_candidates=(
        ~/.bash_completion
    )

    for f in ${bash_completion_candidates[*]}; do
        [[ -f "$f" ]] || continue
        [[ "$BASHRC_debug" -ge 2 ]] && echo "Sourcing $f ..."
        BASH_COMPLETION="$f"
        BASH_COMPLETION_DIR="${f}.d"
        BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_DIR"
        source "$f"
    done
fi

# Google Cloud SDK
[[ "$0" == *bash ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

[[ "$0" == *zsh ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

