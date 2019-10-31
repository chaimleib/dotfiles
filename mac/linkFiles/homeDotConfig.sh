#!/bin/bash
# called by ../linkFiles.sh
# assumes that install_common.sh has been sourced and $link_dir has been set

pushd "$common_dir" >/dev/null
mkdir -p "${HOME}/.config/nvim"
_lnargs \
  .config/karabiner \
  .config/nvim/init.vim \
  .config/nvim/autoload
popd >/dev/null

