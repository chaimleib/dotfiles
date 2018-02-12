#!/bin/bash
have repoactions || return
if [[ "$0" == *bash ]]; then
    if [[ -n "$PROMPT_COMMAND" ]] && [[ "$PROMPT_COMMAND" != *';' ]]; then
        PROMPT_COMMAND="$PROMPT_COMMAND;"
    fi
    PROMPT_COMMAND="$PROMPT_COMMAND"'eval "$(repoactions -e)"'
    export PROMPT_COMMAND
elif [[ -n "$ZSH_NAME" ]]; then
    function repoactions_func() {
        eval "$(repoactions -e)"
    }
    precmd_functions+=( repoactions_func )
fi

