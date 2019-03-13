#!/bin/bash

# Where to store envs
NVM_DIR="$HOME/.nvm/nvm.sh"
export NVM_DIR

# Initialize nvm shell function
nvm_rcs=(
  "$HOME/.nvm/nvm.sh"
  /usr/local/opt/nvm/nvm.sh
  /usr/local/nvm/nvm.sh
)
for rc in "${nvm_rcs[@]}"; do
  [[ -f "$rc" ]] || continue
  . "$rc"
done

# Detect node version from noderc
function noderc_update() {
    if [[ "$PWD" != "$PREV_PWD" ]]; then
        PREV_PWD="$PWD"
        if [[ -e ".nvmrc" ]]; then
            nvm install
        fi
    fi
}

[[ "$0" == *bash ]] && export -f noderc_update

# Run after every user command
PROMPT_COMMAND="$PROMPT_COMMAND; noderc_update"

