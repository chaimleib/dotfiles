#!/bin/bash

function setup_ids() {
    if [[ ! -d "$HOME"/.ssh ]]; then
        mkdir "$HOME"/.ssh
    fi

    local out="$HOME"/.ssh/id_ed25519
    if [[ -e "$out" && -e "$out".pub ]]; then
        return
    fi

    ssh-keygen -t ed25519 -C "chaim.leib.halbert@gmail.com" -f "$out"
    eval "$(ssh-agent -s)"
    ssh-add "$out"
}

setup_ids
