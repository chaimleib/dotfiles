#!/bin/bash

#function yntest() {
#    ( $@ ) && echo yes || echo no
#}

function echovar() {
    echo "${1}=${!1}"
}

