#!/bin/bash
set -e
printf "%-30s %s..." Installing "JDK Language Server (used by neovim)"

library="$HOME"/projects/github

if [[ -e "$library"/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/content.xml ]]; then
  echo "Already installed $pkg"
  exit
fi

mkdir -p ~/projects/github
cd ~/projects/github
if [[ -d eclipse.jdt.ls/.git ]]; then
  cd eclipse.jdt.ls
  git pull
else
  git clone https://github.com/eclipse/eclipse.jdt.ls
  cd eclipse.jdt.ls
fi

source ~/.bashrc.d/*-paths.sh  # set JAVA_HOME, JAVA_OPTS
./mvnw clean verify

