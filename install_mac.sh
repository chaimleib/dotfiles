#!/bin/bash

function abspath() {
    pushd "$1" >/dev/null
    echo "$PWD"
    popd >/dev/null
}

this_dir="$(abspath "$(dirname "$0")")"

function install_mac() {
    $this_dir/osx.sh
    macroot
    machome
}

function macroot() {
    local macroot="$this_dir/macroot"
    [[ -d "$macroot" ]] || return
    
    local d="/Library/Application Support/Razer"
    _slndir "$macroot$d" "$d"
}

function machome() {
    local machome="$this_dir/machome"
    [[ -d "$machome" ]] || return
    
    local d="/Library/Application Support/ControllerMate"
    _lndir "$machome$d" "$HOME$d"
}

function _rmdir() {
    [ -d "$1" ] && rm -rf "$1"
}

function _lndir() {
    _rmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    ln -s "$1" "$2"
}

function _rmfile() {
    [[ -e "$1" ]] && rm "$1"
}

function _lnfile() {
    _rmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    ln -s "$1" "$2"
}
function _srmdir() {
    [ -d "$1" ] && sudo rm -rf "$1"
}

function _slndir() {
    _srmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

function _srmfile() {
    [[ -e "$1" ]] && sudo rm "$1"
}

function _slnfile() {
    _srmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

install_mac

