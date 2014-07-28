#!/bin/bash

function abspath() {
    pushd "$1" >/dev/null
    echo "$PWD"
    popd >/dev/null
}

this_dir="$(abspath "$(dirname "$0")")"

function macroot() {
    local macroot="$this_dir/macroot"
    [[ -d "$macroot" ]] || return
    
    local d="/Library/Application Support/Razer"
    _lndir "$macroot$d" "$d"
}

function _rmdir() {
    [ -d "$1" ] && sudo rm -rf "$1"
}

function _lndir() {
    _rmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

function _rmfile() {
    [[ -e "$1" ]] && sudo rm "$1"
}

function _lnfile() {
    _rmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

macroot

