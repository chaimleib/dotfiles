[[ "$SHELL" =~ '.*zsh' ]] || return

bindkey -e
setopt hist_ignore_dups

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
