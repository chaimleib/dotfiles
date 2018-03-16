#!/bin/bash

have op && have jq || return
function opp() {
    local item="$1"
    if ! op get account &>/dev/null; then
        eval $(op signin my) || return 1
    fi
    op get item "$1" | jq '.details|select(fields!=null).fields[]|select(.designation=="password").value' -r
    return $?
}

function opmy() {
    eval $(op signin my) || return 1
}

