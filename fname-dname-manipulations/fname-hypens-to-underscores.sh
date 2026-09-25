#! /usr/bin/env bash
# fname: fname-hypens-to-underscores
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[ERROR] -- no filename as argument\n"
	exit
else
	FJLM="$ARG"
fi

OUTPUT=$(echo "${FJLM}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././' | tr '-' '_')
echo "${OUTPUT}" | sed 's/"//g'

