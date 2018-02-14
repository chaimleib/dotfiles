#!/bin/bash

[[ -z "$PS1" ]] && return
if [[ "$0" == *bash ]]; then
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
elif [[ -n "$ZSH_NAME" ]]; then
  RESET_COLOR="%{$reset_color%}"
  RED="%{$fg[red]%}"
  GREEN="%{$fg[green]%}"
  YELLOW="%{$fg[yellow]%}"
  BLUE="%{$fg[blue]%}"
  MAGENTA="%{$fg[magenta]%}"
  CYAN="%{$fg[cyan]%}"
  BOLD_RED="%{$fg_bold[red]%}"
  BOLD_GREEN="%{$fg_bold[green]%}"
  BOLD_YELLOW="%{$fg_bold[yellow]%}"
  BOLD_BLUE="%{$fg_bold[blue]%}"
  BOLD_MAGENTA="%{$fg_bold[magenta]%}"
  BOLD_CYAN="%{$fg_bold[cyan]%}"
fi

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

