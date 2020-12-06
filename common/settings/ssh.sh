#!/bin/bash

function setup_ids() {
    if [[ ! -d "$HOME"/.ssh ]]; then
        mkdir "$HOME"/.ssh
    fi

    local out="$HOME"/.ssh/id_rsa
    if [[ -e "$out" && -e "$out".pub ]]; then
        return
    fi

    ssh-keygen -t rsa -C "chaim.leib.halbert@gmail.com" -N '' -f "$out"
    eval "$(ssh-agent -s)"
    ssh-add "$out"
}

setup_ids
