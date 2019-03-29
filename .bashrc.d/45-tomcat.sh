#!/bin/bash

TOMCAT_HOME='/usr/local/opt/tomcat@8/libexec'
if [[ -d "$TOMCAT_HOME" ]]; then
    export TOMCAT_HOME
    alias catalina=$TOMCAT_HOME/bin/catalina.sh
fi

