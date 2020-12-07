#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL build-essential \
    w3m w3m-img  \
    vim \
    python python3 python3-distutils python-distutils-extra \
    nodejs npm

  # open browser to add ssh key to github and allow git cloning in later steps
  w3m https://github.com/settings/ssh/new

  # install rust for vim :PlugUpdate
  # Otherwise, will get bogged down from Language Server Client
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src

  . ~/.bashrc

  # Install plugins and quit
  vim -c :PlugUpdate -c :q -c :q

  if ping -c1 raw.githubusercontent.com >/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh |
      bash
  else
    echo "$0: raw.githubusercontent.com unreachable" >&2
    exit 1
  fi
}

do_install

