#!/bin/bash

export EDITOR="`which vim`"
export VISUAL="$EDITOR"

[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"
