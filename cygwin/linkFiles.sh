#!/bin/bash

if [[ "$0" == "-bash" ]]; then
  echo "This file is not intended to be source-d."
  echo "Call this file as an executable."
  exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

function install_win() {
  winhome
  pushd "$HOME" >/dev/null
  . .bashrc
  popd >/dev/null
}

function winhome() {
  pushd "$this_dir/.." >/dev/null

  _lnargs \
    .bashrc \
    .bashrc.d \
    .bash_completion \
    .bash_completion.d \
    .bash_logout \
    .gitconfig \
    .gitconfig-en \
    .inputrc \
    .vimrc \
    .vim \
    .zshrc \
    local \
    .hushlogin \
    .ee.bcrc \
    .phy.bcrc \
    .profile \
    .tmux.conf

  popd >/dev/null
}

install_win

