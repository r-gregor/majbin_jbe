#! /usr/bin/env bash

# set IFS to newline '\n'
nifs() {
        echo -n "setting IFS to newline ..."
        IFS=$'\n'
        echo " done."
}

# set IFS to orginal ' \t\n'
oifs() {
        echo -n "setting IFS to original value ..."
        IFS=$' \t\n'
        echo " done."
}

nifs

for FFF in $(find . -type f -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" -o -name "*.srt" | grep -v "EN"); do echo mv -v $FFF $(echo $FFF | sed 's/\(.*\)[[:digit:]]\{3,4\}p.*\(.\{3\}$\)/\1\2/'); done

read -p "OK? Press any key to continue and <ctrl+c> to quit!"
for FFF in $(find . -type f -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" -o -name "*.srt" | grep -v "EN"); do mv -v $FFF $(echo $FFF | sed 's/\(.*\)[[:digit:]]\{3,4\}p.*\(.\{3\}$\)/\1\2/'); done

oifs
