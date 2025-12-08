#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path; pyenv init -)"
  #virtualenv cd autoloader
  # if command -v pyenv-virtualenv-init &>/dev/null; then
  #   export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  #   eval "$(pyenv virtualenv-init -)"
  # fi
  pyversion=$(
    pyenv versions |
      sed -En 's/^[^\d]*(3\.[1-9]\d(\.\d+)?).*$/\1/p' |
      sort -rV | head -n1
  )
  if [[ -z "$pyversion" ]]; then
    # use system default
    return
  fi
  pyenv global "$pyversion" >/dev/null
  eval "$(pyenv virtualenv-init -)"
fi

