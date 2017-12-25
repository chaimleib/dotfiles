#!/bin/bash
if have repoactions; then
    PROMPT_COMMAND='eval "$(repoactions -e)";'"$PROMPT_COMMAND"
    export PROMPT_COMMAND
fi

