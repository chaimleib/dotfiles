#!/bin/bash

# Initialize nvm shell function
export NVM_DIR="$HOME/.nvm"
if [ -f $NVM_DIR/nvm.sh ]; then
    . "$NVM_DIR/nvm.sh"
fi

# Detect node version from noderc
function noderc_update() {
    if [ "$PWD" != "$PREV_PWD" ]; then
        PREV_PWD="$PWD"
        if [ -e ".nvmrc" ]; then
            nvm install;
        fi
    fi
}

# Run after every user command
export PROMPT_COMMAND="noderc_update; $PROMPT_COMMAND"

