return
if [[ -n "$ZSH_VERSION" ]]; then
  bindkey -v
elif [[ -n "$BASH_VERSION" ]]; then
  set -o vi
fi
