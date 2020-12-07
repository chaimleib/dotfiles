#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL imagemagick xsel golang-go zip unzip tmux tree
}

do_install

