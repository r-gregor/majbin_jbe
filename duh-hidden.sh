#! /usr/bin/env bash
# filename: duh-hidden.sh
# descpt: du, but with hidden files
# last: 20260922
# ---

gCurDir="."
nLines=0

# cmd="du -hs --total .[^.]* *"
cmd() {
	du -hs --total .[^.]* *
}

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
	cd ${gCurDir} && cmd | sort -hr | head -n ${nLines}
else
	cd ${gCurDir} && cmd | sort -hr
fi

