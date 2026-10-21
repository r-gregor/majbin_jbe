#! /usr/bin/env bash
# fname: txt-fjls-from-dos2unix.sh
# descpt: Convert all txt files in currdir from dos to unix line-endings
# 20261021
# last: 20261021
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
	printf "[e] no such directory: '%s'\n\n" "${CURDIR}"
	exit
fi

read -r -p "[?] all '*.txt' files will be converted from unix to dos line endings -- continue?"

nifs
for FFF in $(find "${CURDIR}" -type f -name "*\.txt"); do unix2dos "${FFF}"; done
oifs

