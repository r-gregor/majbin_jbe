#! /usr/bin/env bash
# fname: string-spaces-to-hypens-en.sh
# descpt: Change string spaces to hypens
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

OUTPUT=$(echo "${STRNG}" | sed 's/ \././' | tr ' ' '-')
printf "%s\n\n" "${OUTPUT}" | sed 's/"//g'

