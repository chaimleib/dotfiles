#!/bin/bash

have op && have jq || return
function opp() {
    local item="$1"
    op get item "$1" | jq '.details.fields[]|select(.designation=="password").value' -r
}

