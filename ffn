#! /usr/bin/env bash

cmd="/usr/bin/firefox"

if [ $# -eq 1 ]; then
    ARG=$1
    nohup $cmd $ARG >&/dev/null &

elif [ $# -eq 0 ]; then
    nohup $cmd >&/dev/null &
else
    echo "Too many arguments!"
    exit 1
fi

