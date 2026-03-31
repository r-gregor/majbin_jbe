#! /usr/bin/env bash
# fname: fname-convert-4-spaces-to-tabs
# 20226031
# last: 20260331
# ---

ARG="$@"

if [ "x${ARG}" = "x" ]; then
	printf "[ERROR] -- no string as argument\n"
	exit
else
	FNAME="$ARG"
fi

echo -n "Converting 4 spaces to tabs for file '${FNAME}' ... "
sed -i 's/ \{4\}/\t/g' "${FNAME}"
printf "[OK].\n"

