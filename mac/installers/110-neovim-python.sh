#!/bin/bash
printf "%-30s %s..." Installing "pyenv-virtualenv for neovim"

function require() {
  have "$1" && return
  printf 'Missing: %s\n' "$1"
  exit 1
}

require nvim
require python
require pyenv
require pyenv-virtualenv

ve3=neovim-py3
if pyenv virtualenvs | grep "^  $ve3" >/dev/null; then
  echo "Already installed"
  exit
fi

get_version() {
  # from https://github.com/momo-lab/pyenv-install-latest/blob/master/bin/pyenv-install-latest
  local query=$1
  [[ -z $query ]] && query=$DEFAULT_QUERY
  if ! pyenv install --list \
    | grep -vE "(^Available versions:|-src|dev|rc|alpha|beta|(a|b)[0-9]+)" \
    | grep -E "^\s*$query" \
    | tail -1 \
    | sed 's/^\s\+//'; then
    printf "Could not determine latest python matching '%s'" "$query"
    exit 1
  fi
}
latestPy3=$(get_version '3\.')

CONFIGURE_OPTS="--enable-optimizations" pyenv install "$latestPy3" &&
  pyenv virtualenv "$latestPy3" "$ve3" >/dev/null &&
  pyenv activate "$ve3" || exit 1

pkg=neovim
printf "%-30s %s (in %s)..." "Installing Python package" "$pkg" "$ve3"
if python -c "import $pkg" &>/dev/null; then
  echo "Already installed $pkg"
else
  pip install "$pkg"
fi

