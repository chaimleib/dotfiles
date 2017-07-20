#!/bin/bash
pkg=virtualenvwrapper
printf "%-30s %s..." "Installing Python package" "$pkg"
if python -c "import $pkg"b &>/dev/null; then
    echo "Already installed $pkg"
else
    sudo easy-install "$pkg"
fi

