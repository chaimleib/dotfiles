#!/usr/bin/env sh

function is_dnf() {
  case "$INSTALL" in
    'sudo dnf'*) return 0 ;;
  esac
  return 1
}

function do_install() {
  [ -z "$INSTALL" ] && echo "INSTALL not set" && return 1

  # Install Brave
  is_dnf &&
    $INSTALL dnf-plugins-core &&
    sudo dnf config-manager addrepo \
      --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo &&
    $INSTALL brave-browser

  # Install 1Password
  is_dnf &&
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc &&
    { printf '%s\n' \
      '[1password]' \
      'name=1Password Stable Channel' \
      'baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch' \
      'enabled=1' \
      'gpgcheck=1' \
      'repo_gpgcheck=1' \
      'gpgkey="https://downloads.1password.com/linux/keys/1password.asc"' |
      sudo tee /etc/yum.repos.d/1password.repo >/dev/null; } &&
    $INSTALL 1password
}

do_install

