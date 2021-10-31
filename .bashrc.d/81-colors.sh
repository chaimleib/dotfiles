#!/bin/bash

[[ -z "$PS1" ]] && return
case "$SHELL" in
  *zsh)
  RESET_COLOR="%f%b"
  RED="%F{red}"
  GREEN="%F{green}"
  YELLOW="%F{yellow}"
  BLUE="%F{blue}"
  MAGENTA="%F{magenta}"
  CYAN="%F{cyan}"
  BOLD_RED="%B%F{red}"
  BOLD_GREEN="%B%F{green}"
  BOLD_YELLOW="%B%F{yellow}"
  BOLD_BLUE="%B%F{blue}"
  BOLD_MAGENTA="%B%F{magenta}"
  BOLD_CYAN="%B%F{cyan}"
  ;;
  *)
  RESET_COLOR='\[\e[0m\]'
  RED='\[\e[31m\]'
  GREEN='\[\e[32m\]'
  YELLOW='\[\e[33m\]'
  BLUE='\[\e[34m\]'
  MAGENTA='\[\e[35m\]'
  CYAN='\[\e[36m\]'
  BOLD_RED='\[\e[31;1m\]'
  BOLD_GREEN='\[\e[32;1m\]'
  BOLD_YELLOW='\[\e[33;1m\]'
  BOLD_BLUE='\[\e[34;1m\]'
  BOLD_MAGENTA='\[\e[35;1m\]'
  BOLD_CYAN='\[\e[36;1m\]'
  ;;
esac

export RESET_COLOR
export RED
export GREEN
export YELLOW
export BLUE
export MAGENTA
export CYAN
export BOLD_RED
export BOLD_GREEN
export BOLD_YELLOW
export BOLD_BLUE
export BOLD_MAGENTA
export BOLD_CYAN

case "$SHELL" in
  *zsh)
    if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
      source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    ;;
esac
