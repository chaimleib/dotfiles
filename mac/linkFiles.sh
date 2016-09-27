#!/bin/bash

if [[ "$0" == "-bash" ]]; then
    echo "This file is not intended to be source-d."
    echo "Call this file as an executable."
    exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"
mac_dir="${this_dir}"
common_dir="$(dirname "$this_dir")"

for f in "${this_dir}/linkFiles/"*; do
    if ! [ -x "$f" ]; then
        echo "$f not executable; skipping"
        continue
    fi
    [[ -n "$dotfiles_DRYRUN" ]] && echo "#> $f"
    . "$f"
done

pushd "$HOME" >/dev/null
. .bashrc
popd >/dev/null

