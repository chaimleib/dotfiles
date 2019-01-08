#!/bin/bash

[[ -z "$PS1" ]] && return

if [[ "$0" == *bash ]] && [[ -z "$BASH_COMPLETION_COMPAT_DIR" ]]; then
  f=~/.bash_completion
  [[ -f "$f" ]] || return
  [[ "$BASHRC_debug" -ge 2 ]] && echo "Sourcing $f ..."
  BASH_COMPLETION="$f"
  BASH_COMPLETION_DIR="${f}.d"
  BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_DIR"
  source "$f"
fi

# Google Cloud SDK
[[ "$0" == *bash ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

[[ "$0" == *zsh ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

