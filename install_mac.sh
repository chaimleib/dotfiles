#!/bin/bash

. "install_common.sh"

this_dir="$(abspath "$(dirname "$0")")"

function install_mac() {
    $this_dir/osx.sh
    macroot
    machome
    pushd "$HOME" >/dev/null
    . .bashrc
    popd >/dev/null
}

function macroot() {
    pushd "$this_dir/macroot" >/dev/null
    
    _slnargs Library/Application\ Support/Razer
    
    popd >/dev/null
}

function machome() {
    pushd "$this_dir/machome"
    
    _lnargs \
        "/Library/Application Support/ControllerMate" \
        .bashrc \
        .bashrc.d \
        .bash_completion \
        .bash_completion.d \
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

