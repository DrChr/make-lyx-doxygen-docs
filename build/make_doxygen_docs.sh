#!/bin/bash
WORKSPACE=$1

function failed() {
    printf "\nCommand '%s' failed, exiting\n" "$*"
    exit -1
}

function do_or_fail() {
    printf "# Executing: %s\n" "$*"
    "$@" || failed "$@"
}

do_or_fail cd "${WORKSPACE:-/script_invoked_without_path_to_workspace_folder}"
do_or_fail git reset --hard 
do_or_fail git clean -xdf
do_or_fail ./autogen.sh
do_or_fail ./configure
#do_or_fail make
do_or_fail cd sourcedoc
do_or_fail make doxydoc
