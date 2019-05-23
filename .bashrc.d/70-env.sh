#!/bin/bash

export EDITOR='vim'
export VISUAL="$EDITOR"
export TIMEFORMAT='%3lR'

# update SHELL to be more accurate
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

