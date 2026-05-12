#! /usr/bin/env bash
# fname: string-to-lower-with-hypens
# 20260331
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[ERROR] -- no string as argument\n"
	exit
else
	STR="$ARG"
fi

OUTPUT=$(echo "${STR}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' | tr ' ' '-')
echo "${OUTPUT}" | sed 's/"//g'
echo "${OUTPUT}" | sed 's/"//g' | xclip     # use xclip on Linux!!

