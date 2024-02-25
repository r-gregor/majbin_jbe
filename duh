#! /usr/bin/env bash

### Name:	Scriptname ...
### Author:	Author ... 
### Date:	 
### Decription:
### 
### 
### 

gCurDir="."
nLines=0

usage() {
cat << EOF
 Usage: $0 < dirpath or . > < nLines >
 	- dirpath: a valid path to directory
 		(Can be left out if no parameters)
 
 	- nLines;  number of top lines to display -- OPTIONAL!
 
EOF
exit 1
}

if [ $# -eq 1 ] && [ -d $1 ]; then
	gCurDir=$1
elif [ $# -eq 1 ] && [ $1 = "-h" ]; then 
	usage
elif [ $# -eq 1 ] && [ ! -d $1 ]; then 
	usage
else
	gCurDir="."
fi

if [ $# -eq 2 ] && [ -d $1 ] && [ ! $2 = "-h" ]; then
	gCurDir=$1
	nLines=$2
fi

if [ ${nLines} -gt 0 ]; then
	sudo du -sh --total ${gCurDir}/* | sort -hr | head -n ${nLines}
else
	sudo du -sh --total ${gCurDir}/* | sort -hr
fi

