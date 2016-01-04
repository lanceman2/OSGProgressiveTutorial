#!/bin/bash

scriptdir="$(dirname ${BASH_SOURCE[0]})" || exit 1
cd "$scriptdir" || exit 1
dir="$(basename $PWD)" || exit 1
# do not run this in common/
[ "$dir" = common ] && exit 1

mod="$(basename $PWD)"
mod="${mod#[0-9][0-9]_}"

set -x

rm -rf CMakeFiles/
rm -f\
 cmake_install.cmake\
 CMakeCache.txt\
 Makefile\
 "$mod"
