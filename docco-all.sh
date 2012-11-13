#!/bin/bash
#
# Recursively generates documentation using docco.
#
# MIT License
# Copyright (c) 2012-Present Aaron Zampaglione <azampagl@azamapagl.com>
#

# Source directory.
src=$1
# Output directory.
out=$2

# The docco command.
cmd="./docco"

recurse() {
  for i in "$1"/*; do
    if [ -d "$i" ]; then
      o=${i/$src/$out}
      eval "$cmd -o $o $i/*"
      recurse "$i"
    fi
  done
}

# Clean out current output directory.
rm -r $out/*
# Execute docco one at the top level.
eval "$cmd -o $out $src/*"
# Recursively call docco.
recurse $src
