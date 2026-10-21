#! /usr/bin/env bash
# fname: fname-to-lower-with-hypens
# descpt: rename file to lower with hypens
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
	FJLM="$ARG"
fi

OUTPUT=$(echo "${FJLM}" |  tr '[:upper:]' '[:lower:]' | sed -e 's/: */_/g' -e 's/,//g' -e 's/ \././g' | tr ' ' '-')
echo "${OUTPUT}" | sed 's/"//g'

