#!/bin/bash

export EDITOR='vim'
export VISUAL="$EDITOR"
export TIMEFORMAT='%3lR'

# By default, SHELL gets set to the user's preferred shell (set via chsh),
# regardless of the shell currently running. I always want new shells to be
# like the currently-running shell unless I specify explicitly.
for shell in bash zsh; do
  case "$0" in
    *$shell)
      case "$SHELL" in
        */$shell) ;;
        *) export SHELL=$(which $shell) ;;
      esac
      ;;
  esac
done

