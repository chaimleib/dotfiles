#!/bin/bash

## Syntax: 
##      visitDir startDir 'command -options'
# Recurses into startDir and executes the given command string in each directory.
function visitDir() {
    local d=`abspath "$1"`
    pushd "$d" >/dev/null
    [[ "$2" != '' ]] && "$2"
    for file in "$d"/*; do 
        [[ -d "$file" ]] && visitDir "$file" "$2"
    done
    popd >/dev/null
}

