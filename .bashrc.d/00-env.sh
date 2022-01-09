#!/bin/bash

if ! have vim && have vi; then
  if vi -h 2>&1 | grep VIM &>/dev/null ; then
    EDITOR='vi --cmd "set nocompat" -u ~/.vimrc'
  else
    EDITOR='vi'
  fi
fi
if have nvim; then
  EDITOR='nvim'
  alias vimdiff='nvim -d'
fi
export EDITOR

export VISUAL="$EDITOR"
export TIMEFORMAT='%3lR'
export RIPGREP_CONFIG_PATH=~/.config/rg/rgrc

# By default, SHELL gets set to the user's preferred shell (set via chsh),
# regardless of the shell currently running. I always want new shells to be
# like the currently-running shell unless I specify explicitly.
cm=$(ps -o pid,comm | awk '$1=='$$' { print $2 }')
case "$cm" in
  -*) export SHELL=$(which "${cm#-}") ;;
  *.sh) ;;
  *sh) export SHELL=$(which "$cm") ;;
esac

case "$TERM" in
  xterm*)
    if [ -e /usr/share/terminfo/x/xterm-256color ]; then
      export TERM=xterm-256color
    elif [ -e /usr/share/terminfo/x/xterm-color ]; then
      export TERM=xterm-color
    else
      export TERM=xterm
    fi
    ;;
  linux)
    [ -n "$FBTERM" ] && export TERM=fbterm
    ;;
esac
