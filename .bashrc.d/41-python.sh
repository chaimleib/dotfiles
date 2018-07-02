#!/bin/bash

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

[ -f /usr/local/bin/virtualenvwrapper.sh ] &&
    . /usr/local/bin/virtualenvwrapper.sh
if have pyenv; then
    # https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper_lazy
fi

