#! /usr/bin/env bash
# fname: fname-rename-spaces-to-hypens-no-confirm
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	echo -e "[E] -- no filename as argument\n"
	exit
else
	FNAME="$ARG"
fi

if [ ! -f "${FNAME}" ]; then
	echo -e "[E] -- no such file\n"
	exit
fi

NEW_FNAME=$(echo "${FNAME}" | sed 's/ \././' | tr ' ' '-')

printf "[i] "
mv -v "${FNAME}" "${NEW_FNAME}"
printf "\n"

