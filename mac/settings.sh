#!/bin/bash

if [[ "$0" == "-bash" ]]; then
    echo "This file is not intended to be source-d."
    echo "Call this file as an executable."
    exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

for script in "$this_dir"/settings/*; do
    if [[ -x "$script" ]] && [[ -f "$script" ]]; then
        "$script"
    fi
done

