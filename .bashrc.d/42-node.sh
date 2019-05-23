#!/bin/bash

# Where to store envs
NVM_DIR="$HOME/.nvm"
export NVM_DIR

# Initialize nvm shell function
nvm_rcs=(
  "$HOME/.nvm/nvm.sh"
  /usr/local/opt/nvm/nvm.sh
  /usr/local/nvm/nvm.sh
)
for rc in "${nvm_rcs[@]}"; do
  [ -f "$rc" ] || continue
  source "$rc"
done

# Detect node version from noderc
function noderc_update() {
    [ "$PWD" != "$OLDPWD" ] && [ -f ".nvmrc" ] && nvm install
}

# Run after every user command
case "$SHELL" in
  */bash)
    export -f noderc_update
    PROMPT_COMMAND="$PROMPT_COMMAND; noderc_update"
    ;;
  */zsh)
    precmd_functions+=( noderc_update )
    ;;
esac

