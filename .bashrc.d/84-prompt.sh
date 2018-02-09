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
elif [[ -n "$ZSH_NAME" ]]; then
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  # %n - $USERNAME
  # %M - full machine hostname
  # %m - hostname up to the first '.'. Int after % for # components
  # %# - # for root, % otherwise
  # %c - trailing component of cwd. Int after % for # components. Tilde
  #      contraction unless %C. Deprecated, equiv to %1~ and %1/.
  # %~ - tilde-contracted cwd. Int after % for # components.
  # %/ - cwd. Int after % for # components.
  # %{...%} - Include escape sequences; string inside should not change cursor
  #           position, except if %G included. Nesting allowed.
  # %G - inside %{...%}, increase string width by 1, or by # after %. Affects
  #      prompt truncation, when in use.
  PROMPT=''
  PROMPT+='${ret_status}%{$reset_color%}'
  PROMPT+='%n'
  PROMPT+=@
  PROMPT+='%{$fg[red]%}%M%{$reset_color%}'
  PROMPT+=:
  PROMPT+='%{$fg_bold[green]%}%~%{$reset_color%}'
  PROMPT+=$'\n'
  export ZSH_THEME_GIT_PROMPT_PREFIX=''
  export ZSH_THEME_GIT_PROMPT_SUFFIX=''
  PROMPT+='$(git_prompt_info)%{$reset_color%} '
  PROMPT+='%# '
  export PROMPT
fi

