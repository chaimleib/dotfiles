#!/bin/bash

# Initialize nvm shell function
export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && \. "$NVM_DIR/nvm.sh"

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

