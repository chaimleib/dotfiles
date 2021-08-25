#!/bin/bash
removePath .

# python
export PYENV_ROOT="$HOME/.pyenv"

# java
if [ -d "/Library/Java/Home" ]; then # Mac
    JAVA_HOME="/Library/Java/Home"
elif [ -d /usr/local/Cellar/openjdk@11 ]; then # homebrew
    JAVA_HOME=$(find “/usr/local/Cellar/openjdk@11” -type d -depth 1|sort|tail -n 1)
elif [ -d "/usr/local/java-current" ]; then # Linux
    JAVA_HOME="/usr/local/java-current"
fi
if [ "$JAVA_HOME" ]; then
  export JAVA_HOME
fi
export JAVA_OPTS="-Xms512m -Xmx4096m"

# Override default binaries with usr binaries
PATH="$JAVA_HOME"/bin:/usr/local/opt/mysql@5.7/bin:"$PYENV_ROOT"/bin:~/go/bin:/usr/local/bin:/usr/local/sbin:"$PATH"

PKG_CONFIG_PATH="$PKG_CONFIG_PATH":/usr/local/lib:/usr/X11/lib/pkgconfig

# Haskell
# prependPath ~/.cabal/bin

# Rust
# prependPath ~/.cargo/bin
