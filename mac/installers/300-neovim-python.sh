#!/bin/bash
set -e
printf "%-30s %s..." Installing "pyenv-virtualenv for neovim"

function abort() { echo "$1" >&2; exit 1; }
function require() { have "$1" || abort "Missing: $1"; }

require nvim
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
  # increases install time on pyenv from 2m to 18m, and not much benefit:
  # CONFIGURE_OPTS="--enable-optimizations"
  pyenv install -v "$latestPy3"

pyenv virtualenv "$latestPy3" "$ve3" >/dev/null
pyenv activate "$ve3"

# upgrade pip to silence a warning
echo
if pip list --outdated | grep pip &>/dev/null; then
  printf "%-30s %s (in %s)...\n" "Upgrading Python package" "pip" "$ve3"
  if logs=$(pip install --upgrade pip 2>&1); then
    echo Done
  else
    echo Failed
    echo "$logs"
    exit 1
  fi
fi

# install neovim python package
printf "%-30s %s (in %s)...\n" "Installing Python package" neovim "$ve3"
if python -c "import neovim" &>/dev/null; then
  echo "Already installed neovim in $ve3"
else
  if logs=$(pip install neovim 2>&1); then
    echo Done
  else
    echo Failed
    echo "$logs"
    exit 1
  fi
fi

pyenv deactivate
pyenv shell system

