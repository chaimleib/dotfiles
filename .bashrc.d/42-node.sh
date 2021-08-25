#!/bin/bash

# Where to store envs
NVM_DIR="$HOME/.nvm"
export NVM_DIR

# Initialize nvm shell function
source "$NVM_DIR"/nvm.sh

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
