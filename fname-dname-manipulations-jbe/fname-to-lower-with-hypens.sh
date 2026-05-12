#! /usr/bin/env bash
# fname: fname-to-lower-with-hypens
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[ERROR] -- no filename as argument\n"
	exit
else
	FJLM="$ARG"
fi

OUTPUT=$(echo "${FJLM}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' | tr ' ' '-')
echo "${OUTPUT}" | sed 's/"//g'

