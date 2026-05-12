#! /usr/bin/env bash

tms=$(date +%Y%m%d_%H%M%S)

if [ $# -ne 1 ]; then
    echo -e "Must supply a *.vtt filename \n"
    exit 1
else
    fname=$1
fi

fname2="${fname}_${tms}.srt"

sed -e '/^..:...... -->/s/\(.*\) --> \(.*\)/00:\1 --> 00:\2/' -e '/^[0-9]\{2\}\:/s/\./,/g' ${fname} > ${fname2}

