#!/bin/bash

[[ -z "$PS1" ]] && return

[[ -e "$HOME/.no-lssys" ]] || lssys

