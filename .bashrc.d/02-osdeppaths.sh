#!/bin/bash

# OS-specific

case $OSTYPE in
darwin*)
  # Qt
  [[ -d /Developer/Qt*/[0-9]*/clang_64/bin ]] &&
  prependPath /Developer/Qt*/[0-9]*/clang_64/bin
  ;;
*linux*)
  # TeX
  TEX_YEAR=$(
  ls /usr/local/texlive/ 2>/dev/null |
  grep -E '^[0-9-]+' |
  sort -r |
  head -1
  )
  if [[ -n "$TEX_YEAR" ]]; then
  # expecting only a directory like x86_64-linux inside bin
  appendPath /usr/local/texlive/$TEX_YEAR/bin/*
  appendPath /usr/local/texlive/$TEX_YEAR/texmf-dist/doc/info INFOPATH
  appendPath /usr/local/texlive/$TEX_YEAR/texmf-dist/doc/man MANPATH
  fi
  ;;
esac

function _addOPPathTree() {
  bin_dirs=(
  bin
  sbin
  )
  if [[ -d "$1" ]]; then
  tree=override
  [[ -d "$1/$tree" ]] &&
  for bin in ${bin_dirs[*]}; do
  prependPath "$1/$tree/$bin"
  done

  tree=provide
  [[ -d "$1/$tree" ]] &&
  for bin in ${bin_dirs[*]}; do
  appendPath "$1/$tree/$bin"
  done
  fi
}

if [[ "$OSTYPE" == darwin* ]]; then
  _addOPPathTree "${HOME}/local/darwin-`uname -m`"
fi
_addOPPathTree "${HOME}/local/$OSTYPE-`uname -m`"
_addOPPathTree "${HOME}/local/all"

