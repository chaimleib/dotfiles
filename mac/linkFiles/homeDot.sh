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
    .gitconfig \
    .gitconfig-en \
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

popd >/dev/null

