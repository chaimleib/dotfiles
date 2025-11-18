#!/bin/bash
removePath .

# python
export PYENV_ROOT="$HOME/.pyenv"

# Override default binaries with usr binaries
PATH="$PYENV_ROOT"/bin:~/go/bin:~/.cargo/bin:~/.local/bin:~/bin:/usr/local/bin:/usr/local/sbin:"$PATH"

[ -d /var/lib/snapd/snap/bin ] && PATH="/var/lib/snapd/snap/bin:$PATH"

# for compiling 3DP firmware
# appendPath ~/.platformio/penv/bin

PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/local/lib:/usr/X11/lib/pkgconfig

if [ -d '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk' ]; then
  case "$SHELL" in
  *bash)
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
    ;;
  *zsh)
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
    ;;
  esac
fi
prependPath /opt/homebrew/sbin
prependPath /opt/homebrew/bin
appendPath ~/.lmstudio/bin
# Haskell
# prependPath ~/.cabal/bin

# Rust
# prependPath ~/.cargo/bin
