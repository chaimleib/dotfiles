return
if [ -n "$ZSH_VERSION" ]; then
  bindkey -v

  setopt no_beep

  export HISTFILE="$HOME"/.config/zsh/histfile
  export HISTSIZE=1000
  export SAVEHIST=1000
  setopt extended_history
  setopt hist_ignore_dups
  setopt hist_verify
  setopt share_history
  setopt hist_find_no_dups
elif [ -n "$BASH_VERSION" ]; then
  set -o vi
fi
