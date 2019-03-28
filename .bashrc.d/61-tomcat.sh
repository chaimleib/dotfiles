#!/bin/bash

TOMCAT_HOME='/usr/local/opt/tomcat/libexec'
if [[ -d "$TOMCAT_HOME" ]]; then
    export TOMCAT_HOME
fi

