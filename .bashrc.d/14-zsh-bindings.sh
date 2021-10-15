[[ "$SHELL" =~ '.*zsh' ]] || return

bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

setopt hist_ignore_dups

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
