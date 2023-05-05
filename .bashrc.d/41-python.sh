#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path; pyenv init -)"
  #virtualenv cd autoloader
  # if command -v pyenv-virtualenv-init &>/dev/null; then
  #   export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  #   eval "$(pyenv virtualenv-init -)"
  # fi
  pyenv global $(pyenv versions | grep -F 3.10 | sort -rV | head -n1)
fi

