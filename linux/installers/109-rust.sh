#!/bin/bash

function do_install() {
  curl https://sh.rustup.rs -sSf | sh
  ~/.cargo/bin/rustup component add rls rust-analysis rust-src
}

do_install

