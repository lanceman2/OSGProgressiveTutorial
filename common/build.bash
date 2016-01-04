#!/bin/bash

scriptdir="$(dirname ${BASH_SOURCE[0]})" || exit 1
cd "$scriptdir" || exit 1
dir="$(basename $PWD)" || exit 1
# do not run this in common/
[ "$dir" = common ] && exit 1

set -x

cmake . || exit 1
make
