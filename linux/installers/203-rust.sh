#!/bin/bash

function do_install() {
  # accept all defaults with yes
  yes '' |
    sh <(curl https://sh.rustup.rs -sSf)
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src
}

do_install

