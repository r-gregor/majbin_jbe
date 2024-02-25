#!/usr/bin/env bash

# timestamp
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

# Start
tms; echo "Starting $0 ..."

# check the number of parameters
if [ $# -ne 1 ]; then
    tms; echo -e "Only ONE parameter allowed!\nUsage:\n\t$(basename $0) <URL, or KeyWord>"
    exit
fi

my_URL=$1
function mycmd() {
    ls $PWD | xargs -IS grep -s --color -Hn $my_URL S
}

#run command ...
mycmd

echo
tms; echo "Done."
