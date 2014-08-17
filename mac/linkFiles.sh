#!/bin/bash

if [[ "$0" == "-bash" ]]; then
    echo "This file is not intended to be source-d."
    echo "Call this file as an executable."
    exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

function install_mac() {
    macroot
    machome
    pushd "$HOME" >/dev/null
    . .bashrc
    popd >/dev/null
}

function macroot() {
    pushd "$this_dir/root" >/dev/null
    _slnargs "Library/Application Support/Razer"
    popd >/dev/null
}

function machome() {
    pushd "$this_dir/home"
    _lnargs \
        "Library/Application Support/ControllerMate"
    popd >/dev/null

    pushd "$this_dir/.."
    _lnargs \
        .bashrc \
        .bashrc.d \
        .bash_completion \
        .bash_completion.d \
        .gitconfig \
        .vimrc \
        .vim \
        local \
        .hushlogin \
        .ee.bcrc \
        .phy.bcrc \
        .profile
    popd >/dev/null
}

install_mac

