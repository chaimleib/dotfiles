#!/usr/bin/env zsh

[[ "$SHELL" == */zsh ]] || return

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

