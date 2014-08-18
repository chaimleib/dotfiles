#!/bin/bash

if [[ ! -d "$HOME"/.ssh ]]; then
    mkdir "$HOME"/.ssh
fi

if [[ -e "$HOME"/.ssh/id_rsa && -e "$HOME"/.ssh/id_rsa.pub ]]; then
    return
fi

ssh-keygen -t rsa -C "chaim.leib.halbert@gmail.com"
eval "$(ssh-agent -s)"
ssh-add "$HOME"/.ssh/id_rsa

