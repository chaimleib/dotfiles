#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path; pyenv init -)"
  #virtualenv cd autoloader
  # if command -v pyenv-virtualenv-init &>/dev/null; then
  #   export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  #   eval "$(pyenv virtualenv-init -)"
  # fi
  pyenv global 2.7.17 3.8.5
fi

