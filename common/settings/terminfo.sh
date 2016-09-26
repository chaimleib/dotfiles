#!/bin/bash

function fixCtrlHMapping() {
  infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
  tic $TERM.ti
  rm $TERM.ti
}

fixCtrlHMapping

