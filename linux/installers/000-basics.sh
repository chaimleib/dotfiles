#!/bin/bash
set -e

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL build-essential \
    w3m w3m-img  \
    vim \
    ripgrep \
    python python3 python3-distutils python-distutils-extra \
    nodejs npm \
    fbterm

  # open browser to add ssh key to github and allow git cloning in later steps
  w3m https://github.com/settings/ssh/new

  mv ~/.gitconfig{,.aside}

  # install rust for vim :PlugUpdate
  # Otherwise, will get bogged down from Language Server Client
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src

  . ~/.bashrc

  # Install plugins
  vim -c :PlugUpdate

  if ping -c1 raw.githubusercontent.com >/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh |
      bash
  else
    echo "$0: raw.githubusercontent.com unreachable" >&2
    return 1
  fi

  mv ~/.gitconfig{.aside,}

  sudo chmod u+s /usr/bin/fbterm
  cat << EOF | sudo tee -a /etc/profile > /dev/null
[ "\$TERM" = 'linux' ] && command -v fbterm >/dev/null && FBTERM=1 exec fbterm
EOF
}

do_install

