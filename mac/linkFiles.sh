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
    pushd "$this_dir/home" >/dev/null
    if [[ ! -d "$HOME/Library/Application Support/ControllerMate" ]]; then
        mkdir "$HOME/Library/Application Support/ControllerMate"
    fi
    _lnargs \
        "Library/Application Support/ControllerMate/Programming.plist" \
        "Library/Keyboard Layouts/Hebrew-Biblical.keylayout" \
        "Library/Keyboard Layouts/Hebrew-Biblical.icns" \
        "Library/Preferences/com.apple.finder.plist" \
        "Library/Preferences/com.apple.Terminal.plist" \
        "Library/Preferences/com.apple.HIToolbox.plist" \
        "Library/Preferences/com.googlecode.iterm2.plist"
    popd >/dev/null

    pushd "$this_dir/.." >/dev/null
    _lnargs \
        .bashrc \
        .bashrc.d \
        .bash_completion \
        .bash_completion.d \
        .bash_logout \
        .vimrc \
        .vim \
        local \
        .hushlogin \
        .ee.bcrc \
        .phy.bcrc \
        .profile

    gitver="$(git --version | grep -o [0-9]\+\.[0-9\.]\+[0-9])"
    if [[ "$gitver" > '2.' ]]; then
        _lnargs .gitconfig
    else
        pushd cygwin/home >/dev/null
        _lnargs .gitconfig
        popd >/dev/null
    fi


    popd >/dev/null
}

install_mac

