#! /usr/bin/env bash
# fname: string-to-lower-with-hypens.sh
# descpt: Change string to lower with hypens and store result in clipboard
# 20260925
# last: 20260925
# ---

ARG="$@"

if [ "${ARG}" = "" ]; then
	echo -e "[ERROR] -- no string as argument\n"
	exit
else
	STR="$ARG"
fi

OUTPUT=$(echo "${STR}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' | tr ' ' '-')
printf "%s\n\n" "${OUTPUT}" | sed 's/"//g'
printf "%s" "${OUTPUT}" | sed 's/"//g' | ${CLPBRDMNGR}

