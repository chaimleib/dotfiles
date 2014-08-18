#!/bin/bash

function abspath() {
    if [[ -d "$1" ]]; then
        pushd "$1" >/dev/null
        echo "$PWD"
        popd >/dev/null
    else
        local file=$(basename  "$1")
        local dir=$(dirname "$1")
        pushd "$dir" >/dev/null
        echo "$PWD/$file"
        popd >/dev/null
    fi 
}

# this_dir="$(abspath "$(dirname "$0")")"

function _slnargs() {
    local this_dir="$PWD"
    for item in "$@"; do
        if [[ -d "$this_dir/$item" ]]; then
            _slndir "$this_dir/$item" "/$item"
        elif [[ -f "$this_dir/$item" ]]; then
            _slnfile "$this_dir/$item" "/$item"
        else
            echo "Could not link '$file'"
        fi
    done
}

function _lnargs() {
    local this_dir="$PWD"
    for item in "$@"; do
        if [[ -d "$this_dir/$item" ]]; then
            _lndir "$this_dir/$item" "$HOME/$item"
        elif [[ -f "$this_dir/$item" ]]; then
            _lnfile "$this_dir/$item" "$HOME/$item"
        else
            echo "Could not link '$file'"
        fi
    done
}

function _rmdir() {
    [ -d "$1" ] && mv "$1"{,.old}
}

function _lndir() {
    if [[ -n "$(readlink "$2")" ]]; then
        echo "Already linked: $2 -> $(readlink "$2")"
        return
    fi
    _rmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    ln -s "$1" "$2"
}

function _rmfile() {
    [[ -e "$1" ]] && mv "$1"{,.old}
}

function _lnfile() {
    if [[ -n "$(readlink "$2")" ]]; then
        echo "Already linked: $2 -> $(readlink "$2")"
        return
    fi
    _rmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    ln -s "$1" "$2"
}

function _srmdir() {
    [ -d "$1" ] && sudo mv "$1"{,.old}
}

function _slndir() {
    if [[ -n "$(readlink "$2")" ]]; then
        echo "Already linked: $2 -> $(readlink "$2")"
        return
    fi
    _srmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

function _srmfile() {
    [[ -e "$1" ]] && sudo mv "$1"{,.old}
}

function _slnfile() {
    if [[ -n "$(readlink "$2")" ]]; then
        echo "Already linked: $2 -> $(readlink "$2")"
        return
    fi
    _srmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    sudo ln -s "$1" "$2"
}

