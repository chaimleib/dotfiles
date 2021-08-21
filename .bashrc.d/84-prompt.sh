#!/bin/bash

function exit_indicator() {
  local exit_indicator
  exit_indicator='$([[ "'"$1"'"'
  exit_indicator+=' == 0 ]] &&'
  exit_indicator+=' echo "'${BOLD_GREEN}'✔ " ||'
  exit_indicator+=' echo "'${BOLD_RED}'✘ "'
  exit_indicator+=')'
  exit_indicator+=$RESET_COLOR
  case "$SHELL" in
    *bash) echo "$exit_indicator" ;;
    *zsh) eval print -P "$exit_indicator" ;;
  esac
}

# Kubernetes context
function kube_prompt_info() {
  if ! have kubectl; then
    return
  fi
  local active_context="$(kubectl config current-context)"
  case "$active_context" in
    *development*) echo -n "k8s:${GREEN}dev${RESET_COLOR}" ;;
    *testing*) echo -n "k8s:${YELLOW}test${RESET_COLOR}" ;;
    *production*) echo -n "k8s:${RED}prod${RESET_COLOR}" ;;
    *) echo -n "k8s:${active_context}" ;;
  esac
}

# GCP context
function gcp_prompt_info() {
  local config_file="$HOME/.config/gcloud/active_config"
  if ! [ -e "$config_file" ]; then
    return
  fi
  local active_config="$(cat "$config_file")"
  case "$active_config" in
    *development*) echo -n "gcp:${GREEN}dev${RESET_COLOR}" ;;
    *testing*) echo -n "gcp:${YELLOW}test${RESET_COLOR}" ;;
    *production*) echo -n "gcp:${RED}prod${RESET_COLOR}" ;;
    default) ;;
    *) echo -n "gcp:${active_config}" ;;
  esac
}
function prompt_configs() {
  local gcp="$(gcp_prompt_info)"
  if [ -z "$gcp" ]; then
    return
  fi
  if [ -n "$gcp" ]; then
    printf '%s' "$gcp"
  fi
  printf ' '
}

if [ -z "$PS1" ]; then
  return
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=verbose
#export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

export HISTCONTROL=ignoredups
if [[ "$0" == *bash ]]; then
    shopt -s histappend
    # https://tiswww.case.edu/php/chet/bash/bashref.html#Controlling-the-Prompt
    # \u - username
    # \h - hostname, 1st segment
    # \H - hostname
    # \n - newline
    # \w - current working directory, tilde-contracted
    # \W - basename of PWD, tilde-contracted
    # \$ - # for root user, else $
    # \[...\] - non-printing characters, for control sequences
    p_user='\u'
    p_host='\H'
    p_cwd='\w'
    p_nl=$'\n'
    p_prompt='\$'
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
    p_user='%n'
    p_host='%M'
    p_cwd='%~'
    p_nl=$'\n'
    p_prompt='%#'
fi

function ps1_func() {
  local last_exit=$?
  local ps1
  if [[ -z "$NOPS" ]]; then
    ps1+="$(exit_indicator "$last_exit")"
    ps1+=$p_user
    ps1+=@
    ps1+="${RED}${p_host}${RESET_COLOR}"
    ps1+=:
    ps1+="${BOLD_GREEN}${p_cwd}${RESET_COLOR}"
    ps1+=$p_nl
    ps1+="$(prompt_configs)"
    local g=$(__git_ps1)
    ps1+="${g:+$g }"
  fi
  ps1+=$p_prompt
  ps1+=' '
  PS1=$ps1
}
case "$SHELL" in
  */bash)
    export -f ps1_func
    PROMPT_COMMAND='ps1_func'
    export PROMPT_COMMAND
    ;;
  */zsh)
    precmd_functions=( ps1_func $precmd_functions )
    ;;
esac

