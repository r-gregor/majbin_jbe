#! /usr/bin/env bash

### Name:		knowledgebase-by-age
### Author:		RgregoR
### Date:		20201223
### Decription:
### Finds entries (files) that are N-days old and sorts them by entry date.
### N-days is an intiger argumet to script. If none supplied: error message and exit
### 
 


gPth="$HOME/Dropbox/ODPRTO"	#EN
gPtn="${gPth}/_PYTHON"
gTxt="${gPth}/_TXT"
gJava="${gPth}/_JAVA"
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
	for FFF in $(find ${lpath}/* -regextype egrep -iregex ".*[^0-9][0-9]{8}\.txt"); do
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
	for gDest in ${gTxt} ${gPtn} ${gJava}; do
		tms; crtc 3
		fillDatabase ${gDest} |sort -nr; done
fi

dT2=$(date +"%s")
tms; crtc 3
tms; echo "Done in $((dT2-dT1)) seconds!"

