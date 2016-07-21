#!/bin/bash

if [[ -d /usr/local/Cellar/tomcat ]]; then
    TOMCAT_HOME="$(brew --prefix tomcat)"
    [ -L "$TOMCAT_HOME" ] && TOMCAT_HOME="$(resolve $(dirname $TOMCAT_HOME) $(readlink $TOMCAT_HOME))/libexec"
    export TOMCAT_HOME

    export JAVA_OPTS="-Xms512m -Xmx1024m"
fi

