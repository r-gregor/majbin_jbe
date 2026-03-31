#! /usr/bin/env bash
# fname: txt-fjls-from-unix2dos
# 20260331
# last: 20260331
# ---

nifs() {
	IFS=$'\n'
}

# set IFS to orginal ' \t\n'
oifs() {
	IFS=$' \t\n'
}

if [ $# -eq 1 ]; then
	CURDIR="$1"
else
	CURDIR="$PWD"
fi

if [ ! -d "$CURDIR" ]; then
	printf "[ERROR] -- no such directory\n"
	exit
fi

read -p "All '*.txt' files will be converted from unix to dos line endings! Continue?"

nifs
for FFF in $(find "${CURDIR}" -type f -name "*\.txt"); do unix2dos "$FFF"; done
oifs

