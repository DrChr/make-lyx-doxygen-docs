#!/bin/bash
WORKSPACE=$1

function failed() {
    printf "Command '%s' failed, exiting\n" "$*"
    exit -1
}

function do_or_fail() {
    printf "# Executing: %s\n" "$*"
    "$@" || failed "$@"
}

do_or_fail cd "${WORKSPACE:-/script_invoked_without_path_to_workspace_folder}"
# git reset --hard && git clean -xdf && 
do_or_fail ./autogen.sh
do_or_fail ./configure
do_or_fail make
do_or_fail make check
do_or_fail make distcheck
echo "GOOD"
