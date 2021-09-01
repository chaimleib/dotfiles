#!/bin/bash

[ -z "$PS1" ] && return

if [[ "$SHELL" == *bash ]] && [[ -z "$BASH_COMPLETION_COMPAT_DIR" ]]; then
  f=~/.bash_completion
  [ -f "$f" ] || return
  [ "$BASHRC_debug" -ge 2 ] && echo "Sourcing $f ..."
  BASH_COMPLETION="$f"
  BASH_COMPLETION_DIR="${f}.d"
  BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_DIR"
  source "$f"
fi

case "$SHELL" in
*zsh)
  if [ -d /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
  fi
  if have brew; then
    brewprefix=$(brew --prefix)
    if [ -d "$brewprefix"/share/zsh/site-functions ]; then
      fpath=("$brewprefix"/share/zsh/site-functions $fpath)
    fi
  fi

  # The following lines were added by compinstall

  zstyle ':completion:*' completer _complete _ignored
  zstyle ':completion:*' expand prefix suffix
  zstyle ':completion:*' file-sort modification
  zstyle ':completion:*' ignore-parents parent pwd ..
  zstyle ':completion:*' insert-unambiguous true
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' list-suffixes true
  zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=* l:|=*'
  zstyle ':completion:*' menu select=0
  zstyle ':completion:*' original true
  zstyle ':completion:*' preserve-prefix '//[^/]##/'
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  zstyle :compinstall filename "/Users/$USER/.zshrc"

  autoload -Uz compinit
  compinit
  # End of lines added by compinstall
  ;;
esac
