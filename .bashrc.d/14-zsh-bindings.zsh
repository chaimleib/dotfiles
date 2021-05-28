[[ "$0" == *zsh ]] || return

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
