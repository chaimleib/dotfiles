#!/bin/bash
set -e
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

eval "$(pyenv init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv virtualenv-init -)"

latestPy3=$(pyenv install --list | grep -E '^\s+3[\.0-9]+$' | tail -n1 | xargs)

echo
echo Installing python "$latestPy3" with pyenv
echo n | # don't reinstall if already have latest
  CONFIGURE_OPTS="--enable-optimizations" pyenv install -v "$latestPy3"

pyenv virtualenv "$latestPy3" "$ve3" >/dev/null
pyenv activate "$ve3"

pkg=neovim
echo
printf "%-30s %s (in %s)..." "Installing Python package" "$pkg" "$ve3"
if python -c "import $pkg" &>/dev/null; then
  echo "Already installed $pkg in $ve3"
else
  pip install "$pkg"
fi
pyenv deactivate
pyenv shell system

