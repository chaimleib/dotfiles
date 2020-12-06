#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL w3m w3m-img
  # open browser to add ssh key to github and allow git cloning in later steps
  w3m https://github.com/settings/ssh/new
}

do_install

