#!/bin/bash

if [[ "$0" == "-bash" ]]; then
    echo "This file is not intended to be source-d."
    echo "Call this file as an executable."
    exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

function install_common() {
    commonrepos
}


function commonrepos() {
    pushd "$this_dir/../repos" >/dev/null
    
    git clone https://github.com/vim-ruby/vim-ruby
    git clone https://github.com/chaimleib/vim-renpy
}

install_common

