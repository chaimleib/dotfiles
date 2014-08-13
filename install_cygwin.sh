#!/bin/bash

. "install_common.sh"

this_dir="$(abspath "$(dirname "$0")")"

function install_win() {
    winhome
    pushd "$HOME" >/dev/null
    . .bashrc
    popd >/dev/null
}

function winhome() {
    pushd "$this_dir" >/dev/null
    
    _lnargs \
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

install_win

