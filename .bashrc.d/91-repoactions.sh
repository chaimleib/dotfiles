#!/bin/bash
if have repoactions; then
    if [[ -n "$PROMPT_COMMAND" ]] && [[ "$PROMPT_COMMAND" != *';' ]]; then
        PROMPT_COMMAND="$PROMPT_COMMAND;"
    fi
    PROMPT_COMMAND="$PROMPT_COMMAND"'eval "$(repoactions -e)"'
    export PROMPT_COMMAND
fi

