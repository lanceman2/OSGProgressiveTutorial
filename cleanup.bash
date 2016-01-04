#!/bin/bash

scriptdir="$(dirname ${BASH_SOURCE[0]})" || exit 1
cd "$scriptdir" || exit 1

for dir in [0-9][0-9]_* ; do
    if [ -x cleanup.bash ] ; then
        cd "$dir" || exit 1
        echo -e "\ncleaning: $dir"
        ./cleanup.bash || exit 1
        cd - > /dev/null
    fi
done

echo -e "\ncleaning ."
set -x

rm -f launcherList
