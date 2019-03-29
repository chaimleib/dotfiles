#!/bin/bash

if [ -d /Library/Java/JavaVirtualMachines/jdk1.8.*.jdk/Contents/Home ]; then # Mac
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.*.jdk/Contents/Home
elif [ -d "/usr/local/java-current" ]; then # Linux
    export JAVA_HOME="/usr/local/java-current"
fi
export JAVA_OPTS="-Xms512m -Xmx4096m"
prependPath "$JAVA_HOME"/bin

