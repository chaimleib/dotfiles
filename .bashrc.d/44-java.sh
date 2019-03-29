#!/bin/bash

if [ -d "/Library/Java/Home" ]; then # Mac
    JAVA_HOME="/Library/Java/Home"
elif [ -d "/usr/local/java-current" ]; then # Linux
    JAVA_HOME="/usr/local/java-current"
fi
if [ "$JAVA_HOME" ]; then
  export JAVA_HOME
  prependPath "$JAVA_HOME"/bin
fi
export JAVA_OPTS="-Xms512m -Xmx4096m"

