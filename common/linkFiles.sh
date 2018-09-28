#!/bin/bash

if [[ "$0" == "-bash" ]]; then
    echo "This file is not intended to be source-d."
    echo "Call this file as an executable."
    exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

function install_common() {
    commonhome
    commonconfig
    pushd "$HOME" >/dev/null
    . .bashrc
    popd >/dev/null
}

function commonhome() {
    pushd "$this_dir/.." >/dev/null
    
    _lnargs \
        .bashrc \
        .bashrc.d \
        .bash_completion \
        .bash_completion.d \
        .bash_logout \
        .gitconfig \
        .gitconfig-en \
        .vimrc \
        .vim \
        local \
        .hushlogin \
        .ee.bcrc \
        .phy.bcrc \
        .profile \
        .tmux.conf

    popd >/dev/null
}

function commonconfig() {
    mkdir -p "${HOME}/.config/nvim"
    pushd "$this_dir/../.config" >/dev/null
    _lnargs \
        nvim/init.vim \
        nvim/autoload
    
    popd >/dev/null
}

install_common

