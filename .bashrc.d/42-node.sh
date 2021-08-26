#!/bin/bash

# Where to store envs
NVM_DIR="$HOME/.nvm"

# Initialize shell function/vars
if command -v fnm &>/dev/null; then
  eval "$(fnm env)"
elif [ -f "$NVM_DIR"/nvm.sh ]; then
  export NVM_DIR
  source "$NVM_DIR"/nvm.sh
fi

# disabled: load .nvmrc on cd
# # Detect node version from noderc
# function noderc_update() {
#     [ "$PWD" != "$OLDPWD" ] && [ -f ".nvmrc" ] && nvm use
# }

# # Run after every user command
# case "$SHELL" in
#   */bash)
#     export -f noderc_update
#     PROMPT_COMMAND="$PROMPT_COMMAND; noderc_update"
#     ;;
#   */zsh)
#     precmd_functions+=( noderc_update )
#     ;;
# esac
