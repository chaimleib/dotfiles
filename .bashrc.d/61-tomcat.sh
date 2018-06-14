#!/bin/bash

TOMCAT_HOME='/usr/local/opt/tomcat/libexec'
if [[ -d "$TOMCAT_HOME" ]]; then
    export TOMCAT_HOME
    export JAVA_OPTS="-Xms512m -Xmx1024m -XX:PermSize=512m -XX:MaxPermSize=2048m"
fi

