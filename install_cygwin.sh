#!/bin/bash

function abspath() {
    pushd "$1" >/dev/null
    echo "$PWD"
    popd >/dev/null
}

this_dir="$(abspath "$(dirname "$0")")"

function install_win() {
    winhome
}

function winhome() {
    local winhome="$this_dir"
    [[ -d "$winhome" ]] || return
    
    local d=".bashrc"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".bashrc.d"
    _lndir "$winhome/$d" "$HOME/$d"
    d=".bash_completion"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".bash_completion.d"
    _lndir "$winhome/$d" "$HOME/$d"
    d=".vimrc"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".vim"
    _lndir "$winhome/$d" "$HOME/$d"
    d="local"
    _lndir "$winhome/$d" "$HOME/$d"
    d=".hushlogin"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".ee.bcrc"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".phy.bcrc"
    _lnfile "$winhome/$d" "$HOME/$d"
    d=".profile"
    _lnfile "$winhome/$d" "$HOME/$d"
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

install_win

