#!/bin/bash

[[ -z "$PS1" ]] && return

## If logging into a foreign server...
if ! [[ $USER = 'chaimleib' ]]; then
    lssys
fi

