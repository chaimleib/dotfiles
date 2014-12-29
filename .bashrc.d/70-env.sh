#!/bin/bash

export EDITOR="`which vim`"
export VISUAL="$EDITOR"

# Python
[[ -f "$HOME/.pythonrc.py" ]] && export PYTHONSTARTUP="$HOME/.pythonrc.py"

# Perl
if [[ -d "${HOME}/.perl5" ]]; then
    export PERL_MB_OPT="--install_base \"${HOME}/.perl5\""
    export PERL_MM_OPT="INSTALL_BASE=${HOME}/.perl5"
    export PERL5LIB="${HOME}/.perl5/lib/perl5"
fi
