#! /usr/bin/env bash
# fname: fname-rename-underscores-to-hypens-no-confirm
# descpt: rename file from underscores to hypens -- NO CONFIRM
# 20226031
# last: 20260331
# ---

# === GLOBALS ===
ARG="$@"

# === MAIN ===
if [ "${ARG}" = "" ]; then
	printf "[e] -- no filename as argument\n\n"
	exit 1
else
	FNAME="$ARG"
fi

if [ ! -f "${FNAME}" ]; then
	printf "[e] -- no such file\n\n"
	exit 1
fi

NEW_FNAME=$(echo "${FNAME}" | sed 's/ \././' | tr '_' '-')

printf "[i] "
mv -v "${FNAME}" "${NEW_FNAME}"
printf "\n"

