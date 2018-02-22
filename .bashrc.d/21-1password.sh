#!/bin/bash

have op && have jq || return
function opp() {
    local item="$1"
    op get account &>/dev/null || eval $(op signin my) | grep -v '^#' >&2 || return 1
    op get item "$1" | jq '.details.fields[]|select(.designation=="password").value' -r
    return $?
}

