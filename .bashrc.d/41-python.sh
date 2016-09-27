#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

# bash completion for pyenv
# disabled, since it pushes the rvm path from first position and causes warnings.
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

