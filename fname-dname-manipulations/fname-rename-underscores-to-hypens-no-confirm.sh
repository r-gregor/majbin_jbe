#! /usr/bin/env bash
# fname: fname-rename-underscores-to-hypens-no-confirm
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[E] -- no filename as argument\n"
	exit
else
	FNAME="$ARG"
fi

if [ ! -f "${FNAME}" ]; then
	printf "[E] -- no such file\n"
	exit
fi

NEW_FNAME=$(echo "${FNAME}" | sed 's/ \././' | tr '_' '-')

printf "[i] "
mv -v "${FNAME}" "${NEW_FNAME}"
printf "\n"

