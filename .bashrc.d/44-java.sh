#!/bin/bash

if [ -d "/Library/Java/Home" ]; then # Mac
    JAVA_HOME="/Library/Java/Home"
elif [ -d "/usr/local/java-current" ]; then # Linux
    JAVA_HOME="/usr/local/java-current"
    prependPath "$JAVA_HOME"/bin
fi
export JAVA_HOME
export JAVA_OPTS="-Xms512m -Xmx2048m"

