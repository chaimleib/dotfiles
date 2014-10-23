#!/bin/bash

function linkGit() {
    gitver="$(git --version | grep -o [0-9]\+\.[0-9\.]\+[0-9])"
    if [[ "$gitver" > '2.' ]]; then
        _lnargs .gitconfig
    else
        pushd common/home >/dev/null
        _lnargs .gitconfig
        popd >/dev/null
    fi

    popd >/dev/null
}

linkGit
