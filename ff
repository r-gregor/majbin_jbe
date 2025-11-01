#! /usr/bin/env bash

cmd="/usr/bin/firefox"

if [ $# -eq 1 ]; then
    ARG=$1
    $cmd $ARG &

elif [ $# -eq 0 ]; then
    $cmd &
else
    echo -e "Too many arguments!\n"
    exit 1
fi
