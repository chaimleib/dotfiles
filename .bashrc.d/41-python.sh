#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

if have pyenv; then
  eval "$(pyenv init -)"
  if have pyenv-virtualenv-init; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv virtualenv-init -)"
    # provide py3 for neovim if installed
    if pyenv virtualenvs | grep "^  $ve3" >/dev/null; then
      export NEOVIM_PYTHON3_HOST_PROG=$(
        pyenv activate neovim-py3 >/dev/null && pyenv which python
      )
    fi
  fi
  pyenv global 2.7.17 3.8.5
fi

