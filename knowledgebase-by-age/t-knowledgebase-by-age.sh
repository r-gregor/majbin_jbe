#! /usr/bin/env bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	 
### Decription:
### 
### 
### 



gPth="$HOME/Dropbox/ODPRTO"	#EN
gSrc="${gPth}/_TXT"

gTmpLst="$HOME/.tmp/list.txt"
gDaysDiff=0
gToday=$(date +%Y%m%d)

crtc() {
    for ((i=1; i<=$1; i++)); do
        echo -n "-"
    done
    echo
}


usage() {
cat <<EOF
	Usage:
	$0 [arg]
	- arg: integer: number of days back from today
	
EOF
}

# timestamp
tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}


fillDatabase() {
	lpath=$1
	for FFF in $(find ${gSrc}/* -regextype egrep -iregex ".*[^0-9][0-9]{8}\.txt"); do
		numpart=$(echo $FFF | sed 's/\(.*\)\([[:digit:]]\{8\}\).*/\2/')
		if [[ $numpart -ge $minNum ]]; then
			echo "$numpart $FFF" # >> ${gTmpLst}
		fi; done
}


# MAIN

# check for number of parameters to bash command
if [[ ! $# -eq 1 ]]; then
	tms; echo "No argument!"
	usage
	exit 1
else
	gDaysDiff=$1
	minNum=$((${gToday}-${gDaysDiff}))
	
	clear
	tms; echo "Starting: $0"
	tms; echo "Displaying files newer than $minNum"
	dT1=$(date +"%s")
	tms; crtc 3
	fillDatabase ${gSrc} | sort -nr
fi

dT2=$(date +"%s")
tms; crtc 3
tms; echo "Done in $((dT2-dT1)) seconds!"

