#!/bin/bash

[[ -z "$PS1" ]] && return

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=verbose
#export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

export HISTCONTROL=ignoredups
if [[ "$0" == *bash ]]; then
  shopt -s histappend;
  export PROMPT_COMMAND='__git_ps1 "$([[ "$?" -eq 0 ]] && echo "\[\e[32;1m\]" || echo "\[\e[31;1m\]")➜ \e[0m\]\u@\[\e[31m\]`hostname`\[\e[0m\]:\[\e[32;1m\]\w\[\e[0m\]\n" "\$ " "(%s) "'
elif [[ "$0" == *zsh ]]; then
  export PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
fi

