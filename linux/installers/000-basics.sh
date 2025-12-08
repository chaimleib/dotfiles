#!/usr/bin/env sh
set -e

function is_pacman() {
  case "$INSTALL" in
    'sudo pacman'*) return 0 ;;
  esac
  return 1
}

function is_apk() {
  case "$INSTALL" in
    'sudo apk'*) return 0 ;;
  esac
  return 1
}

function is_apt() {
  case "$INSTALL" in
    'sudo apt'*) return 0 ;;
  esac
  return 1
}

function is_dnf() {
  case "$INSTALL" in
    'sudo dnf'*) return 0 ;;
  esac
  return 1
}

# function wait_for_browser() {
#   if command -v brave-browser >/dev/null; then
#     tmpdir=$(mktemp -d)
#     cp -r ~/.config/BraveSoftware/Brave-Browser/ "$tmpdir"
#     rm -rf "$tmpdir"/Singleton*
#     brave-browser --user-data-dir="$tmpdir" "$1"
#     rm -rf "$tmpdir"
#   else
#     w3m "$1"
#   fi
# }

function do_install() {
  [ -z "$INSTALL" ] && echo "INSTALL not set" && return 1

  $INSTALL \
    $( (is_pacman && echo base-devel) ||
      (is_apk && echo build-base) ||
      (is_apt && echo build-essential) ) \
      autoconf automake \
    $(is_apk && echo gcr-dev webkit2gtk-dev) \
      gperf \
      w3m \
    $( (is_pacman && echo imlib2) ||
      (is_apk && echo imlib2) ||
      (is_dnf && echo imlib2) ||
      (is_apt && echo w3m-img) ) \
    neovim \
    tree \
    ripgrep \
    git \
    go \
    bash zsh \
    tmux \
    $(is_apk && echo man-db man-pages) \
    python3 $(is_apt && echo python3-distutils) \
    $( (is_pacman && echo python-pip) ||
      (is_dnf && echo python3-pip) ||
      (is_apk && echo py3-pip) ) \
    nodejs $( (is_dnf && echo nodejs-npm) || echo npm)

  # open browser to add ssh key to github and allow git cloning in later steps
  # echo Checking if we need to register pubkey with github.com...
  # if ! grep -F github.com ~/.ssh/known_hosts &>/dev/null; then
  #   wait_for_browser https://github.com/settings/ssh/new
  # fi

  . ~/.bashrc
}

do_install

