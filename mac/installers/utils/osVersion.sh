#!/bin/bash

osVer="$(system_profiler SPSoftwareDataType Software |
  grep 'System Version' |
  grep -o '[0-9]\+\.[0-9\.]\+'
)" # Gives 10_9_4

echo "$osVer"
