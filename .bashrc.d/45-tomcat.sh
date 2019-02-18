#!/bin/bash

TOMCAT_HOME='/usr/local/opt/tomcat@8/libexec'
if [[ -d "$TOMCAT_HOME" ]]; then
    export TOMCAT_HOME
    export JAVA_OPTS="-Xms512m -Xmx1024m"
fi

