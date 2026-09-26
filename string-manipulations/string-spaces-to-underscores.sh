#! /usr/bin/env bash
# fname: string-spaces-to-underscores.sh
# descpt: Change string spaces to underscores
# 20260925
# last: 20260925
# ---

ARG="$@"

if [ "${ARG}" = "" ]; then
	printf "[ERROR] -- no string as argument\n"
	exit
else
	STRNG="$ARG"
fi

OUTPUT=$(echo "${STRNG}" | sed 's/ \././'  | tr ' ' '_')
printf "%s\n\n" "${OUTPUT}" | sed 's/"//g'
