#!/bin/bash
#######################################################################
#                                                                     #
#   Bash_login file                                                   #
#                                                                     #
#   commands to perform from the bash shell at login time             #
#   (sourced from .bash_profile)                                      #
#                                                                     #
#######################################################################

## Run only once
[ -n "$CHAIMLEIBSDOTFILES" ] && return
[ -z "$PS1" ] && return

## Settings prelude...
[ -z $BASHRC_debug ] && export BASHRC_debug=1

## Meat
[ "$BASHRC_debug" -ge 2 ] && echo "Running ~/.bashrc ..."

## Google GCP
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

## Set up local settings
[ "$BASHRC_debug" -ge 1 ] && echo ">> Loading local rc's..."
if [ -d ~/.bashrc.d ]; then
  for file in ~/.bashrc.d/*.sh ; do
    if [ -x ${file} ]; then
      if [ "$BASHRC_debug" -ge 3 ]; then
        echo "Running ${file} ..."
      fi
      if [ "$BASHRC_debug" -ge 4 ]; then
        time . "$file"
      else
        source "${file}" # zsh likes source instead of . ?
      fi
    fi
  done
fi

## Settings finale...
unset BASHRC_debug
CHAIMLEIBSDOTFILES=1
