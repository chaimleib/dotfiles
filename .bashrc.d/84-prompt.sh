#!/bin/bash

[[ -z "$PS1" ]] && return

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=verbose
#export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

export PROMPT_COMMAND='__git_ps1 "\u@\[\e[31m\]`hostname`\[\e[0m\]:\[\e[32;1m\]\w\[\e[0m\]\n" "\$ " "(%s) "'
export HISTCONTROL=ignoredups
shopt -s histappend;

