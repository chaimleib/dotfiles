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
  # https://tiswww.case.edu/php/chet/bash/bashref.html#Controlling-the-Prompt
  # \u - username
  # \h - hostname, 1st segment
  # \H - hostname
  # \n - newline
  # \w - current working directory, tilde-contracted
  # \W - basename of PWD, tilde-contracted
  # \$ - # for root user, else $
  # \[...\] - non-printing characters, for control sequences
  RED='\[\e[31m\]'
  GREEN='\[\e[32m\]'
  BOLD_RED='\[\e[31;1m\]'
  BOLD_GREEN='\[\e[32;1m\]'
  RESET_COLOR='\[\e[0m\]'
  PROMPT_COMMAND='__git_ps1 "'
  exit_indicator='$('
  exit_indicator+='[[ "$?" -eq 0 ]] &&'
  exit_indicator+=' echo "'$BOLD_GREEN'" ||'
  exit_indicator+=' echo "'$BOLD_RED'"'
  exit_indicator+=')'
  exit_indicator+='➜ '
  exit_indicator+=$RESET_COLOR
  PROMPT_COMMAND+="$exit_indicator"
  PROMPT_COMMAND+='\u'
  PROMPT_COMMAND+='@'
  PROMPT_COMMAND+=$RED'\H'$RESET_COLOR
  PROMPT_COMMAND+=':'
  PROMPT_COMMAND+=$BOLD_GREEN'\w'$RESET_COLOR
  PROMPT_COMMAND+='\n'
  PROMPT_COMMAND+='"'
  PROMPT_COMMAND+=' '
  PROMPT_COMMAND+='"\$ "'
  PROMPT_COMMAND+=' '
  PROMPT_COMMAND+='"(%s) "'
  export PROMPT_COMMAND
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

