#!/bin/bash
set -e

function is_pacman() {
  case "$INSTALL" in
    'sudo pacman'*) return 0 ;;
  esac
  return 1
}

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL \
    $(is_pacman && echo base-devel || echo build-essential) \
    w3m $(is_pacman && echo imlib2 || echo w3m-img) \
    neovim \
    tree \
    ripgrep \
    python python3 python3-distutils python-distutils-extra \
    nodejs npm

  # open browser to add ssh key to github and allow git cloning in later steps
  w3m https://github.com/settings/ssh/new

  mv ~/.gitconfig{,.aside}

  # install rust for vim :PlugUpdate
  # Otherwise, will get bogged down from Language Server Client
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src

  sudo pip3 install pynvim  # required for vim plug roxma/nvim-yarp

  . ~/.bashrc

  # Install plugins
  nvim -c :PlugUpdate

  if ping -c1 raw.githubusercontent.com >/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh |
      bash
  else
    echo "$0: raw.githubusercontent.com unreachable" >&2
    return 1
  fi

  mv ~/.gitconfig{.aside,}
}

do_install

