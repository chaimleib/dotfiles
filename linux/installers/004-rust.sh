#!/bin/bash

function do_install() {
  curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src
}

do_install

