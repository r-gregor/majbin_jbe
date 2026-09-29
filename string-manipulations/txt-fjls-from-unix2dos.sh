#! /usr/bin/env bash
# fname: txt-fjls-from-unix2dos-en.sh
# descpt: Convert all txt files in currdir from unix to dos line-endings
# 20260925
# last: 20260925
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
	printf "[E] -- no such directory\n"
	exit
fi

read -r -p "[?] All '*.txt' files will be converted from unix to dos line endings! Continue?"

nifs
for FFF in $(find "${CURDIR}" -type f -name "*\.txt"); do unix2dos "$FFF"; done
oifs

