#!/bin/bash

#export http_proxy=http://192.168.2.1:8080
#export ftp_proxy=ftp://192.168.2.1:8080

case "$HOSTNAME" in
raspberrypi*)
    export http_proxy=http://127.0.0.1:8080
    export ftp_proxy=ftp://127.0.0.1:8080
    ;;
*) ;;
esac

