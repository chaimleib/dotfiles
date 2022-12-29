#!/bin/bash
removePath .

# python
export PYENV_ROOT="$HOME/.pyenv"

# Override default binaries with usr binaries
PATH="$PYENV_ROOT"/bin:~/go/bin:~/.cargo/bin:usr/local/bin:/usr/local/sbin:"$PATH"

[ -d /usr/local/opt/mysql@5.7 ] && PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# java
if [ -d "/Library/Java/Home" ]; then # Mac
    JAVA_HOME="/Library/Java/Home"
elif [ -d /usr/local/Cellar/openjdk@11 ]; then # homebrew
    JAVA_HOME=$(find "/usr/local/Cellar/openjdk@11" -type d -depth 1|sort|tail -n 1)
elif [ -d "/usr/local/java-current" ]; then # Linux
    JAVA_HOME="/usr/local/java-current"
fi
if [ -n "$JAVA_HOME" ] && [ -d "$JAVA_HOME" ]; then
  export JAVA_HOME
  PATH="$JAVA_HOME/bin:$PATH"
fi
export JAVA_OPTS="-Xms512m -Xmx4096m"

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
# Haskell
# prependPath ~/.cabal/bin

# Rust
# prependPath ~/.cargo/bin
