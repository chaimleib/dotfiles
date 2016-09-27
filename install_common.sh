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

# Modifies fs root using sudo
function _slnargs() {
    local this_dir="$PWD"
    for item in "$@"; do
        if [[ -d "$this_dir/$item" ]]; then
            _slndir "$this_dir/$item" "/$item"
        elif [[ -f "$this_dir/$item" ]]; then
            _slnfile "$this_dir/$item" "/$item"
        else
            echo "Could not link '$item'"
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
            echo "Could not link '$item'"
        fi
    done
}

function _linkExists() {
    if [[ "$(readlink "$2")" == "$1" ]]; then
        echo "Already linked: $2 -> $1"
        return
    fi
    return 1
}

function _rmdir() {
    [[ -d "$1" ]] || return
    [[ -n "$dotfiles_DRYRUN" ]] && echo "mv $1{,.old}" && return
    mv "$1"{,.old}
}

function _lndir() {
    _linkExists "$@" && return
    _rmdir "$2"
    echo "ln -s \"$1\" \"$2\""
    [[ -n "$dotfiles_DRYRUN" ]] && return
    ln -s "$1" "$2"
}

function _rmfile() {
    [[ -e "$1" ]] || return
    [[ -n "$dotfiles_DRYRUN" ]] && echo "mv $1{,.old}" && return
    mv "$1"{,.old}
}

function _lnfile() {
    _linkExists "$@" && return
    _rmfile "$2"
    echo "ln -s \"$1\" \"$2\""
    [[ -n "$dotfiles_DRYRUN" ]] || ln -s "$1" "$2"
}

function _srmdir() {
    [ -d "$1" ] || return
    [[ -n "$dotfiles_DRYRUN" ]] && echo "sudo mv $1{,.old}" && return
    sudo mv "$1"{,.old}
}

function _slndir() {
    _linkExists "$@" && return
    _srmdir "$2"
    echo "sudo ln -s \"$1\" \"$2\""
    [[ -n "$dotfiles_DRYRUN" ]] && return
    sudo ln -s "$1" "$2"
}

function _srmfile() {
    [[ -e "$1" ]] || return
    [[ -n "$dotfiles_DRYRUN" ]] && echo "sudo mv $1{,.old}" && return
    sudo mv "$1"{,.old}
}

function _slnfile() {
    _linkExists "$@" && return
    _srmfile "$2"
    echo "sudo ln -s \"$1\" \"$2\""
    [[ -n "$dotfiles_DRYRUN" ]] && return
    sudo ln -s "$1" "$2"
}

