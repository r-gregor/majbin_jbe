#! /usr/bin/env bash

curryr=2020

if [ $# -ne 1 ]; then
    myyr=$curryr
else
    myyr=$1
fi

# find * -maxdepth 1 -type f -regex ".*${myyr}....\..*" | sort -n | head -n20
find * -maxdepth 1 -type f -regex ".*${myyr}[0-9][0-9][0-9][0-9]\..*" | sort -n | head -n20

