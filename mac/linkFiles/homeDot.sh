#!/bin/bash
# called by ../linkFiles.sh
# assumes that install_common.sh has been sourced and $common_dir has been set

pushd "$common_dir" >/dev/null
_lnargs \
    .bashrc \
    .bashrc.d \
    .bash_completion \
    .bash_completion.d \
    .bash_logout \
    .vimrc \
    .vim \
    .zshrc \
    local \
    .hushlogin \
    .ee.bcrc \
    .phy.bcrc \
    .profile \
    .pythonrc.py \
    .tmux.conf

gitver="$(git --version | grep -o [0-9]\+\.[0-9\.]\+[0-9])"
if [[ "$gitver" > '2.' ]]; then
    _lnargs .gitconfig
else
    pushd cygwin/home >/dev/null
    _lnargs .gitconfig
    popd >/dev/null
fi

popd >/dev/null

