#! /usr/bin/env bash
# fname: string-spaces-to-hypens.sh
# descpt: Change string spaces to hypens
# 20260925
# last: 20260925
# ---

ARG="$@"

if [ "${ARG}" = "" ]; then
	printf "[e] -- no string as argument\n"
	exit
else
	STRNG="$ARG"
fi

OUTPUT=$(echo "${STRNG}" | sed 's/ \././' | tr ' ' '-')
printf "%s\n\n" "${OUTPUT}" | sed 's/"//g'

