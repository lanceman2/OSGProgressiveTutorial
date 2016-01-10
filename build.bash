#!/bin/bash

######################################################################
#                    CONFIGURE
######################################################################

# OpenSceneGraph-Data from url:
# http://www.openscenegraph.org/downloads/stable_releases/
# OpenSceneGraph-3.4.0/data/OpenSceneGraph-Data-3.4.0.zip
# Ya, get it and unzip it to this or some directory, if it's
# not there already.

export OSG_FILE_PATH=/usr/local/share/OpenSceneGraph-Data


# LD_LIBRARY_PATH may be needed to let the linker/loader find the OSG
# shared libraries; and maybe not depending on how your OSG is
# installed on your system.  LD_LIBRARY_PATH is not needed it examples
# are compiled with RPATH set to the path where the OSG shared  libraries
# are.

#export LD_LIBRARY_PATH=/usr/local/lib64


######################################################################
######################################################################

function Init()
{
    if [ ! -d "$OSG_FILE_PATH" ] ; then
        echo "OSG_FILE_PATH=$OSG_FILE_PATH is not a directory"
        exit 1
    fi

    scriptdir="$(dirname ${BASH_SOURCE[0]})" || exit 1
    cd "$scriptdir" || exit 1
    scriptdir="$PWD"

    rm -f launcherList

    local beginc=
    local endc=

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        beginc='\x1b[45;1m'
        endc='\x1b[0m'
    fi
    for dir in [0-9][0-9]_* ; do
        if [ -x $dir/build.bash ] && [ ! -d $dir/CMakeFiles ] ; then
            cd "$dir" || exit 1
                echo -e "${beginc}         Building $dir\n${endc}"
                ./build.bash || exit 1
            cd - > /dev/null || exit 1
        fi
        x="$dir/${dir##[0-9][0-9]_}"
        if [ -f "$dir"/run.txt ] ; then
            echo -n "cd \"$dir\" && " >> launcherList
            cat "$dir"/run.txt >> launcherList
        else
            [ -x "$x" ] && echo "$x" >> launcherList
        fi
    done
}

Init

