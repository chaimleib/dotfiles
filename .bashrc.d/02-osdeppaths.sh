#!/bin/bash

# OS-specific

function _addOPPathTree() {
    bin_dirs=(
        bin
        sbin
        )
    if [[ -d "$1" ]]; then
        tree=override
        [[ -d "$1/$tree" ]] &&
            for bin in ${bin_dirs[*]}; do
                prependPath "$1/$tree/$bin"
            done
        
        tree=provide
        [[ -d "$1/$tree" ]] &&
            for bin in ${bin_dirs[*]}; do
                appendPath "$1/$tree/$bin"
            done
    fi
}

if [[ "$OSTYPE" == darwin* ]]; then
    _addOPPathTree "${HOME}/local/darwin-`uname -m`"
fi
_addOPPathTree "${HOME}/local/$OSTYPE-`uname -m`"
_addOPPathTree "${HOME}/local/all"

