#!/bin/bash
WORKSPACE=$1
[ -d "$WORSKPACE" ] || exit 2
cd "$WORKSPACE" || exit 3

function failed() {
    printf "Command '%s' failed, exiting\n" "$*"
    exit -1
}

function do_or_fail() {
    printf "# Executing: %s\n" "$*"
    "$@" || failed "$@"
}


# git reset --hard && git clean -xdf && 
do_or_fail ./autogen.sh
do_or_fail ./configure
do_or_fail make
do_or_fail make check
do_or_fail make distcheck
echo "GOOD"
